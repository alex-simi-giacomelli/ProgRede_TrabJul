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
                                                    
        escreve resposta ao                    
    servSocket especificando                     lê resposta do clientSocket
    endereço IP, número de porta 
            do cliente
                                                        fecha o clientSocket
                                                        
# Programando o Cliente

Importar biblioteca
Criar uma classe
Criar fluxo de entrada
Cria socket de cliente
Traduz  nome de hospedeiro ao endereço IP usando DNS
Cria datagrama com dados para enviar, comprimento, endereço IP, porta
Envia datagrama ao servidor
Lê datagrama do servidor
Imprime os dados recebidos do servidor
Fecha a conexão

# Programando o Servidor
Importar biblioteca
Criar uma classe
Cria socket para datagramas na porta 9876
Inicio do laço
Aloca memória para receber datagrama
Recebe datagrama
Obtém endereço IP, no. de porta do remetente
Cria datagrama p/ enviar ao cliente
Escreve datagrama no socket
Fim do laço, volta ao início e aguarda chegar outro datagrama

