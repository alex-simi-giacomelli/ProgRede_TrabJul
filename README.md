=begin
# ProgRede_TrabJul
================================
# Programação para Redes
    Este documento descreve uma aplicação de troca de mensagens. São utilizados conceitos e lógica de funcionamento oriundos dos   serviços de DNS e de e-mail.
  A aplicação em questão, nesta fase, prevê os seguintes hosts participantes:
    - Servidor central: armazena e informa domínio e endereço IP de cada servidor local. Haverá uma instância de teste com host.

# Programação com sockets usando UDP - será configurado um cliente para teste com o servidor
# Alguns conceitos:
    - UDP não tem conexão entre cliente eservidor;
    - não tem "handshaking"(aperto de mão);
    - o remetente coloca explicitamente o endereço IP e porta de destino;
    - o servidor deve extrair o IP e porta do datagrama do recebido;
    - UDP os dados transmitidos podem chegar fora de ordem ou perdidos;
    - do ponto de vista da aplicação UDP provê transferência não confiável de datagramas entre cliente e servidor.

# Interações entre cliente e servidor

            SERIDOR                                    CLIENTE
            
         cria socket, porta=x,
       p/ pedido que chega                            cria socket
                servSocket =                        clientSocket = 
       aSession.bind(hostName, port)        aSession.connect(hostName, port)
        
        
            Lê o pedido do                      cria, endereça (nomeHosp, porta=x,
            servSocket                          envia pedido em datagrama
                                                    usando socketCliente
                                                    
    escreve resposta ao servSocket           
    especificando endereço IP,                    lê resposta do clientSocket
    número de porta do cliente
    sock.send(mesg, flags[, dest])
                                                        fecha o clientSocket
=end

# Programando o Cliente

#Importar biblioteca
require 'socket'
require 'timeout'
# Criar fluxo de entrada
$port = 12345
$host = 'localhost'
# Cria socket de cliente
client = UDPSocket.new
puts "Qual eh a mensagem?"
# Traduz  nome de hospedeiro ao endereço IP usando DNS
#conecta a um endereço
client.connect($host, $port)
#Cria datagrama com dados para enviar, comprimento, endereço IP, porta
#Envia datagrama ao servidor
#Envia os dados p/ servidor
msg= gets.chomp
client.send(msg, 0)
#Lê datagrama do servidor
#Imprime os dados recebidos do servidor
timeout(10) do
	msg_rec = client.recvfrom(80)
	puts msg_rec[0]
	puts msg_rec[1]
	puts "A conexao foi encerrada."
end
#Fecha a conexão, como é UDP não precisa de comando.



# Programando o Servidor

# Importar biblioteca
require 'socket'
#Cria socket para datagramas
#Inicializa o socket
$port = 12345
$host = 'localhost'
server = UDPSocket.new
puts "Servidor inicializado!!!"
# Vincula a um endereço
server.bind($host, $port)
# Inicio do laço
# Aloca memória para receber datagrama
# Recebe datagrama
# Recebe os dados do cliente
# Obtém endereço IP, no. de porta do remetente
# Cria datagrama p/ enviar ao cliente
# Escreve datagrama no socket
loop do
	msg = server.recvfrom(125)
	puts "Mensagem de #{msg[1][2]} na porta #{msg[1][1]}: '#{msg[0]}'"
# Envia os dados
	server.send(msg[0].upcase,0,msg[1][2], msg[1][1])
end
#Fim do laço, volta ao início e aguarda chegar outro datagrama

