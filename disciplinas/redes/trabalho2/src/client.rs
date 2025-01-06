use std::io::{stdin, BufRead, BufReader, Write};
use std::net::TcpStream;
use std::{fs, thread};

use trabalho2::*;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut args = std::env::args().skip(1);
    let server = args.next().expect("No server address.");
    let port = args.next().unwrap_or("9090".to_string());

    let server = format!("{}:{}", server, port);

    let mut is_chat = false;

    let mut stream = TcpStream::connect(&server)?;
    println!("Connected to tcp://{}", &server);

    for line in stdin().lines() {
        let line = line.unwrap();
        let mut words = line.split(' ').map(|w| w.trim());

        let command = words.next().unwrap();

        match command {
            "Sair" => {
                stream.write_all("Sair\n".as_bytes())?;

                if is_chat {
                    is_chat = false;
                } else {
                    println!("Desconectando");
                    break;
                }
            }
            "Arquivo" => {
                if let Some(filename) = words.next() {
                    stream.write_all(format!("Arquivo\n{}\n", filename).as_bytes())?;

                    if let Some(Message::Dados { name, data, hash, .. }) = stream.recv_message() {
                        if get_hash(&data) == hash {
                            println!("Escrevendo arquivo: {}", name);
                            fs::write(name, &data).unwrap();
                        }
                        else {
                            println!("Erro ao receber arquivo: Hash inválida.");
                        }
                    }
                } else {
                    println!("Missing filename.");
                    continue;
                }
            }
            "Chat" => {
                stream.write_all("Chat\n".as_bytes())?;
                println!("Modo chat. Digite Sair para voltar.");
                is_chat = true;
            }
            _ => {
                stream.write_all(format!("Text\n{}\n", line).as_bytes())?;

                let stream = stream.try_clone()?;

                thread::spawn(move || {
                    let mut buf_read = BufReader::new(&stream);
                    loop { 
                        let mut text = String::new();
                        buf_read.read_line(&mut text).unwrap();

                        if is_chat {
                            print!("Chat: {}", text);
                        } else {
                            break;
                        }
                    }
                });
            }
        }
    }

    Ok(())
}
