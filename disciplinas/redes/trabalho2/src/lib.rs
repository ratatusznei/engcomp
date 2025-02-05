use std::fmt;
use std::io::{BufRead, BufReader, Write};
use std::net::TcpStream;

use sha2::{Sha256, Digest};

pub enum Message {
    /// Campos separados por quebra de linha \n
    Sair,
    Arquivo {
        name: String,
    },
    Chat,

    Text(String),

    NaoEncontrado,
    Dados {
        name: String,
        hash: String,
        filesize: usize,
        data: Vec<u8>,
    },
}

impl fmt::Display for Message {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> Result<(), fmt::Error> {
        match self {
            Message::Sair => write!(f, "Sair"),
            Message::Arquivo { name } => write!(f, "Arquivo {{ name: {} }}", name),
            Message::Chat => write!(f, "Chat"),
            Message::Text(text) => write!(f, "Text {{ {} }}", text),
            Message::NaoEncontrado => write!(f, "NaoEncontrado"),
            Message::Dados {
                name,
                hash,
                filesize,
                ..
            } => write!(
                f,
                "Dados {{ name: {}, hash: {}, filesize: {} }}",
                name, hash, filesize
            ),
        }
    }
}

pub trait MessageStream {
    fn send_message(&mut self, message: Message);
    fn recv_message(&mut self) -> Option<Message>;
}

impl Message {
    pub fn into_bytes(self) -> Vec<u8> {
        let mut vec = vec![];

        match self {
            Message::Sair => vec.extend("Sair\n".as_bytes()),
            Message::Arquivo { name } => {
                vec.extend("Arquivo\n".as_bytes());
                vec.extend(name.as_bytes());
                vec.extend("\n".as_bytes());
            }
            Message::Chat => vec.extend("Chat\n".as_bytes()),
            Message::Text(text) => {
                vec.extend("Text\n".as_bytes());
                vec.extend(text.as_bytes());
                vec.extend("\n".as_bytes());
            }
            Message::NaoEncontrado => vec.extend("NaoEncontrado\n".as_bytes()),
            Message::Dados {
                name,
                hash,
                filesize,
                data,
            } => {
                vec.extend("Dados\n".as_bytes());
                vec.extend(name.as_bytes());
                vec.extend("\n".as_bytes());
                vec.extend(hash.as_bytes());
                vec.extend("\n".as_bytes());
                vec.extend(filesize.to_string().as_bytes());
                vec.extend("\n".as_bytes());
                vec.extend(data);
            }
        }

        vec
    }

    pub fn from_reader<T>(buf_read: &mut T, command: &str) -> Option<Self>
    where
        T: BufRead,
    {
        match command.trim() {
            "Sair" => Some(Message::Sair),
            "Arquivo" => {
                let mut name = String::new();
                buf_read.read_line(&mut name).ok()?;

                let name = name.trim().to_string();
                Some(Message::Arquivo { name })
            }
            "Chat" => Some(Message::Chat),
            "Text" => {
                let mut text = String::new();
                buf_read.read_line(&mut text).ok()?;

                let text = text.trim().to_string();
                Some(Message::Text(text))
            }
            "NaoEncontrado" => Some(Message::NaoEncontrado),
            "Dados" => {
                let mut name = String::new();
                buf_read.read_line(&mut name).ok()?;

                let mut hash = String::new();
                buf_read.read_line(&mut hash).ok()?;

                let mut filesize = String::new();
                buf_read.read_line(&mut filesize).ok()?;

                let filesize: usize = filesize.trim().parse().ok()?;
                let mut data = vec![0;filesize];

                buf_read.read_exact(&mut data).ok()?;

                let name = name.trim().to_string();
                let hash = hash.trim().to_string();
                Some(Message::Dados {
                    name,
                    hash,
                    filesize,
                    data,
                })
            }
            _ => None,
        }
    }
}

impl MessageStream for TcpStream {
    fn send_message(&mut self, message: Message) {
        eprintln!("--> {}", message);
        self.write_all(&message.into_bytes())
            .expect("Failed to send message.");
    }

    fn recv_message(&mut self) -> Option<Message> {
        let mut buf_read = BufReader::new(self);

        let mut command = String::new();
        buf_read.read_line(&mut command).ok()?;

        if let Some(msg) = Message::from_reader(&mut buf_read, &command) {
            eprintln!("<-- {}", msg);
            Some(msg)
        } else {
            eprintln!("Received malformed message.");
            None
        }
    }
}

pub fn get_hash(data: &[u8]) -> String {
    let mut hasher = Sha256::new();
    hasher.update(data);
    format!("{:x}", hasher.finalize())
}
