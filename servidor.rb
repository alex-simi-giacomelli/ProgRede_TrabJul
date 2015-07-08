# Cliente UDP

require 'socket'
require 'timeout'

$port = 12345
$host = 'localhost'

#inicializa o socket
client = UDPSocket.new

#conecta a um endereço
client.connect($host, $port)

#envia os dados p/ servidor
puts "Qual eh a mensagem?"
msg = gets.chomp
client.send(msg, 0)

#recebe os dados do servidor
timeout(10) do
	msg_rec = client.recvfrom(80)
	puts "Nome: #{msg_rec[0]}\nProtocolo   Porta     End1        End2 \n#{msg_rec[1]}"
	puts "A conexao foi encerrada."	
end