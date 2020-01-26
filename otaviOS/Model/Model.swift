//
//  Model.swift
//  otaviOS
//
//  Created by Otavio on 23/01/20.
//  Copyright © 2020 Raieiros Studio. All rights reserved.
//

import UIKit

class Model {
    static let instance = Model()
    
    var isConsoleCracked: Bool = false
    var hasRootAccess: Bool = false
    var hasInternetExplorerAccess: Bool = false
    
    
    var consoleKeys: [String : String]
    var consoleRootKeys: [String : String]
    var consoleInvalidCommandError: String
    var consoleRootRequiredError: String
    
    
    func getConsoleHeader() -> String {
        return "IPHONE_XR:~ " + (self.hasRootAccess ? "root#" : "guest$") + "> "
    }
    
    
    private init() {
        self.consoleInvalidCommandError = "O comando é inválido. Utilize o comando [ help ]"
        
        self.consoleRootRequiredError = "Erro ao executar comando, o usuário ROOT é necessário."
    
        
        self.consoleKeys = [
            //help
            "" : "Utilize o comando [ help ]",
            "--help" : "A sintaxe correta do comando é: [ help ]",
            "help" : "Comandos disponíveis:\n\t[ help ]\n\t[ otavio ]\n\t[ clear ]\n\t[ exit ]\n\t[ metasploit ]\n\t[ root ]\n\nComandos root:\n\t[ ie-provide-access ]",
            "help --help" : "A sintaxe correta do comando é: [ help ]",
            
            //utils
            "exit" : "O console irá fechar em instantes.",
            "exit --help" : "O comando finaliza o processo do console.",
            "clear" : "",
            "clear --help" : "O comando limpa o console.",
            
            //otavio
            "otavio" : "Utilize [ otavio ][ --help ] para mais informações",
            "otavio --help" : "",
            //...
            
            //metasploit
            "metasploit" : "Utilize [ metasploit ][ --help ] para mais informações",
            "metasploit --help" : "Comandos disponíveis:\n\t[ metasploit-get-rootkey ] : Retorna a senha do root.\n\nMétodos:\n\t[ --soft ]\n\t[ --normal ]\n\t[ --force ]",
            "metasploit-get-rootkey": "Falha ao executar comando. Defina um método, exemplo: [ metasploit-get-rootkey ][ --soft ]",
            "metasploit-get-rootkey --soft" : "Falha ao capturar a senha do root, tente o método [ --normal ]",
            "metasploit-get-rootkey --normal" : "Falha ao capturar a senha do root, tente o método [ --force ]",
            "metasploit-get-rootkey --force" : "Sucesso ao capturar a senha do root!\n\nSenha: sacola",
            
            //root
            "root" : "Utilize [ root ][ --help ] para mais informações",
            "root --help" : "Comandos disponíveis:\n\t[ root -p SENHA ] : Entra no usuário root.\n\t[ root -guest ] : Entra no usuário guest, sem privilégios de root.",
            "root -p sacola" : "Sucesso. Usuário root logado.",
            "root -guest" : "Sucesso. Usuário guest logado."
        ]
        
        self.consoleRootKeys = [
            //ie-provide-access
            "ie-provide-access" : "Utilize [ ie-provide-access ][ --help ] para mais informações",
            "ie-provide-access --help" : "Comandos disponíveis:\n\t[ ie-provide-access ] : Altera a permissão de acesso da Internet Explorer.\n\nNível de acesso:\n\t[ --guest ]\n\t[ --root ]",
            "ie-provide-access --guest" : "Permissão guest ativada. O programa estará inacessível",
            "ie-provide-access --root" : "Sucesso. Permissão root ativada. O programa pode ser acessado pelo Desktop."
        ]
    }
}
