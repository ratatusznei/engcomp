use std::fs;
use std::io::{stdin, Write};
use std::net::{TcpListener, TcpStream};
use std::sync::Arc;
use std::sync::Mutex;
use std::thread;

use trabalho2::*;

fn main() -> std::io::Result<()> {
    let port = std::env::args().nth(1).unwrap_or(String::from("9090"));
    let tcp_listener = TcpListener::bind(format!("0.0.0.0:{port}"))?;
    println!("Listening on tcp://0.0.0.0:{port}");

    while let Ok((stream, _addr)) = tcp_listener.accept() {
        thread::spawn(|| handle_connection(stream));
    }

    Ok(())
}

fn handle_connection(mut stream: TcpStream) {
    println!("Cliente conectado.");

    let is_chat = Arc::new(Mutex::new(false));

    loop {
        match stream.recv_message() {
            Some(Message::Sair) => {
                if *is_chat.lock().unwrap() {
                    *is_chat.lock().unwrap() = false;
                }
                else {
                    break;
                }
            },
            Some(Message::Arquivo { name }) => {
                println!("Enviando arquivo: {name}");
                if let Ok(data) = fs::read(&name) {
                    stream.send_message(Message::Dados {
                        name,
                        hash: get_hash(&data),
                        filesize: data.len(),
                        data,
                    });
                } else {
                    stream.send_message(Message::NaoEncontrado);
                }
            }
            Some(Message::Chat) => {
                *is_chat.lock().unwrap() = true;

                let mut stream = stream.try_clone().unwrap();
                let is_chat = Arc::clone(&is_chat);
                thread::spawn(move || {
                    loop {
                        let mut buf = String::new();
                        stdin().read_line(&mut buf).unwrap();

                        if *is_chat.lock().unwrap() {
                            stream.write_all(buf.as_bytes()).unwrap_or(());
                        }
                        else {
                            break;
                        }
                    }
                });
            }
            Some(Message::Text(text)) => {
                if *is_chat.lock().unwrap() {
                    println!("Chat: {}", text);
                }
            }
            _ => break,
        }
    }
}
