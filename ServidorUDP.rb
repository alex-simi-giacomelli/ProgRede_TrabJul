# Servidor UDP

require 'socket'
require 'rdbi-driver-sqlite3'

#Inicializa o socket
server = UDPSocket.new
puts "Servidor Central inicializado!!!"

#Vincula a um endereço
server.bind("", 2100)

# Conecta ao Bco de Dados
db = RDBI.connect(:SQLite3, :database => "registroDominio.db")
puts "Conectado!! \n"

reply = nil
vazio = '""'
# Recebe os dados do cliente
loop {
	guardaSolic, msg = server.recvfrom(1024)
	puts guardaSolic
	dadosRcb = guardaSolic.split
		rcb_ip = msg[3]
		rcb_porta = msg[1]
	if dadosRcb[0] == "REG"
		if dadosRcb[1] != nil && dadosRcb[2] != nil
			begin
				puts 'Rcb Sol REG'
				db.execute("insert into registros(dominio, ip) values  (#{dadosRcb[1]},	#{dadosRcb[2]})")
				puts "REGOK == Reg Dominio Rlz c_Sucesso!"
				server.send "REGOK", 0, rcb_ip, rcb_porta
			rescue
				puts "REGFALHA == Dominio ja existe"
				server.send "REGFALHA", 0, rcb_ip, rcb_porta
			end
		else
			puts "Erro inesperado"
			server.send "FALHA", 0, rcb_ip, rcb_porta
		end
	elsif dadosRcb[0] == "IP"
		if dadosRcb[1] != nil
			puts 'Rcb Sol IP'
			
			
			rn =  db.execute("select ip from registros where dominio = #{dadosRcb[1]}")			
			rn.fetch(:all).each do |row|
				reply = row
			
			end
			if 	reply != nil
				puts "IPOK == Enviando IP"
				server.send "IPOK #{reply}", 0, rcb_ip, rcb_porta
			elsif reply == nil
				puts "IPFALHA == End IP inexistente"
				server.send "IPFALHA", 0, rcb_ip, rcb_porta
			end
		else
			puts "Erro inesperado"
			server.send "FALHA", 0, rcb_ip, rcb_porta
		end
	else
		puts "Erro inesperado"
		server.send "FALHA", 0, rcb_ip, rcb_porta
	end
}
server.close

