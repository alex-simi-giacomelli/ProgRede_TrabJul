# Servidor UDP

require 'socket'

$port = 12345
$host = 'localhost'

#Inicializa o socket
server = UDPSocket.new
puts "Servidor inicializado!!!"

#Vincula a um endereço
server.bind($host, $port)

# Recebe os dados do cliente
loop do
	msg = server.recvfrom(125)
	puts "Mensagem de #{msg[1][2]} na porta #{msg[1][1]}: '#{msg[0]}'"
	
# Envia os dados
	server.send(msg[0].upcase,0,msg[1][2], msg[1][1])
end