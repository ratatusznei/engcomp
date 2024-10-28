use std::net::UdpSocket;
use std::thread;
use std::fs;
use std::sync::Arc;

use trabalho1::*;

fn get_file_list() -> Vec<(String, u32, u32)> {
    fs::read_dir("./public")
        .expect("./public not found.")
        .flatten()
        .map(|entry| 
            (
                entry.file_name().into_string().unwrap(), 
                entry.metadata().map(|metadata| metadata.len() as u32).unwrap(),
                512
            )
        )
        .collect()
}

fn get_file_info(file_name: &str, files: &Vec<(String, u32, u32)>) -> Option<Message> {
    for (id, (file, len, block_size)) in files.iter().enumerate() {
        if file_name == file {
            let mut block_count = len / block_size; 
            if len % block_size != 0 { 
                block_count += 1
            }
            return Some(Message::info(block_count, *block_size, *len, id as u32, &file));
        }
    }

    None
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let socket = UdpSocket::bind("0.0.0.0:3400")?;
    let files = get_file_list();
    let mut data = vec![];

    for (file_name, _len, _block_size) in &files {
        let file_name = format!("./public/{file_name}");
        data.push(fs::read(&file_name).unwrap());
    }

    let files: Arc<Vec<(String, u32, u32)>> = Arc::from(files);
    let data: Arc<Vec<Vec<u8>>> = Arc::from(data);

    loop {
        let message = socket.recv_message();

        if let Some((Message::GetInfo { file_name }, src)) = message {
            if let Some(info) = get_file_info(&file_name, files.as_ref()) {
                socket.send_message(src, info)?;
            }
            else {
                let not_found = Message::not_found(&file_name);
                socket.send_message(src, not_found)?;
            }
        }

        else if let Some((Message::GetBlocks { start_block, end_block, file_id }, src)) = message {
            let socket = socket.try_clone()?;
            let files = Arc::clone(&files);
            let data = Arc::clone(&data);

            thread::spawn(move || {
                let (file_name, file_size, block_size) = &files[file_id as usize];
                let file_data = &data[file_id as usize];

                for block_num in start_block..end_block {
                    let start_byte = (block_num * *block_size) as usize;
                    let end_byte = std::cmp::min(start_byte + (*block_size as usize), *file_size as usize);

                    let buf = &file_data[start_byte..end_byte];
                    let block = Message::block(file_id, block_num, buf);
                    socket.send_message(src, block).unwrap();
                }

                println!("All blocks sent for {file_name}.");
            });
        }
    }
}
