use std::net::UdpSocket;
use std::env;
use std::fs;
use std::time::Duration;

use trabalho1::*;

fn get_info(socket: &UdpSocket, server_ip: &str, file_name: &str) -> Option<Message> {
    let get_info = Message::get_info(file_name);
    socket.send_message(server_ip, get_info).ok()?;

    socket.set_read_timeout(Some(Duration::from_secs(3))).unwrap();
    loop {
        if let Some((message, _)) = socket.recv_message() {
            match message {
                Message::Info { .. } => {
                    socket.set_read_timeout(None).unwrap();
                    return Some(message)
                }
                _ => {
                    socket.set_read_timeout(None).unwrap();
                    return None
                }
            }
        }
        else {
            println!("No INFO blocks received, sending GETINFO again...");
            let get_info = Message::get_info(file_name);
            socket.send_message(server_ip, get_info).ok()?;
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let args: Vec<_> = env::args().collect();
    if args.len() < 2 { println!("Usage: {} server:3400 filename.txt", args[0]); return Ok(()); }

    let server_ip = &args[1];
    let requested_file = &args[2];

    let socket = UdpSocket::bind("0.0.0.0:3401")?;

    if let Some(Message::Info { block_count, block_size, file_size, file_id, .. }) = get_info(&socket, server_ip, requested_file) {
        let mut file_data = vec![0u8; file_size as usize];
        let mut received = vec![false; block_count as usize];

        let get_blocks = Message::get_blocks(file_id, 0, block_count);
        socket.send_message(server_ip, get_blocks)?;

        socket.set_read_timeout(Some(Duration::from_secs(3))).unwrap();

        loop {
            while let Some((Message::Block { block_number, data, .. }, _)) = socket.recv_message() {
                if !received[block_number as usize] {
                    received[block_number as usize] = true;

                    let start_byte = (block_number * block_size) as usize;
                    let end_byte = std::cmp::min(start_byte + (block_size as usize), file_size as usize);
                    let end_of_data = end_byte - start_byte;

                    file_data[start_byte..end_byte].clone_from_slice(&data[..end_of_data]);
                }
            }

            let first = received.iter().position(|e| *e == false);
            let last = received.iter().rposition(|e| *e == false);

            println!("Requesting missing blocks {:?} - {:?}", first, last);

            if let (Some(first), Some(last)) = (first, last) {
                if first >= last {
                    break;
                }

                let get_blocks = Message::get_blocks(file_id, first as u32, (last as u32) + 1);
                socket.send_message(server_ip, get_blocks)?;
            }
            else {
                break;
            }
        }

        fs::write("result.txt", &file_data)?;
        println!("File result.txt created.");
    }

    Ok(())
}
