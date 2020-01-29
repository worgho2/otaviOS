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
    
    var isSoundMuted: Bool = false
    
    var isConsoleCracked: Bool = false
    var hasRootAccess: Bool = false
    var hasInternetExplorerAccess: Bool = false
    
    var consoleKeys: [String : String]
    var consoleRootKeys: [String : String]
    var consoleInvalidCommandError: String
    var consoleRootRequiredError: String
    var consoleFontColor: UIColor
    
    func getConsoleHeader() -> String {
        return "IPHONE_XR:~ " + (self.hasRootAccess ? "root#" : "guest$") + "> "
    }
    
    private init() {
        self.consoleInvalidCommandError = "O comando é inválido. Utilize o comando [ help ]"
        self.consoleRootRequiredError = "Erro ao executar comando, o usuário ROOT é necessário."
        self.consoleFontColor = .white
        
        self.consoleKeys = [
            //help
            "" : "Utilize o comando [ help ]",
            "help" : "------------------------HELP------------------------\n\nComandos:\n\t[ exit ]\n\t[ clear ]\n\t[ color ]\n\t[ otavio ] - Em construção\n\t[ metasploit ]\n\t[ sudo ]\n\t[ ie ] - root necessário",
            
            //exit
            "exit" : "O console irá fechar em instantes.",
            "exit --help" : "------------------------HELP------------------------\n\nO comando finaliza o processo do console.",
            "exit -h" : "------------------------HELP------------------------\n\nO comando finaliza o processo do console.",
            
            //clear
            "clear" : "",
            "clear --help" : "------------------------HELP------------------------\n\nO comando limpa o console.",
            "clear --h" : "------------------------HELP------------------------\n\nO comando limpa o console.",
            
            //color
            "color" : "------------------------HELP------------------------\n\nO comando altera a cor do texto do console.\n\nParâmetros:\n\t[ -white ] : Branco\n\t[ -green ] : Verde\n\t[ -blue ] : Azul\n\t[ -red ] : Vermelho.\n\nExemplo: [ color -green ]",
            "color --help" : "------------------------HELP------------------------\n\nO comando altera a cor do texto do console.\n\nParâmetros:\n\t[ -white ] : Branco\n\t[ -green ] : Verde\n\t[ -blue ] : Azul\n\t[ -red ] : Vermelho.\n\nExemplo: [ color -green ]",
            "color -h" : "------------------------HELP------------------------\n\nO comando altera a cor do texto do console.\n\nParâmetros:\n\t[ -white ] : Branco\n\t[ -green ] : Verde\n\t[ -blue ] : Azul\n\t[ -red ] : Vermelho.\n\nExemplo: [ color -green ]",
            "color -white" : "",
            "color -green" : "",
            "color -blue" : "",
            "color -red" : "",
            
            //otavio
            "otavio" : "comando em construção",
            "otavio --help" : "comando em construção",
            "otavio -h" : "comando em construção",
            //...
            
            //metasploit
            "metasploit" : "------------------------HELP------------------------\n\nMétodos:\n\t[ get-rk ] : Retorna a senha do root.\n\t\t[ -s ] : soft\n\t\t[ -n ] : normal\n\t\t[ -f ] : force\n\nExemplo: [ metasploit get-rk -s ]",
            "metasploit --help" : "------------------------HELP------------------------\n\nMétodos:\n\t[ get-rk ] : Retorna a senha do root.\n\t\t[ -s ] : soft\n\t\t[ -n ] : normal\n\t\t[ -f ] : force\n\nExemplo: [ metasploit get-rk -s ]",
            "metasploit -h" : "------------------------HELP------------------------\n\nMétodos:\n\t[ get-rk ] : Retorna a senha do root.\n\t\t[ -s ] : soft\n\t\t[ -n ] : normal\n\t\t[ -f ] : force\n\nExemplo: [ metasploit get-rk -s ]",
            
            "metasploit get-rk": "Erro. Defina um parâmetro para o método [ get-rk ]\n\nExemplo: [ metasploit get-rk -s ]",
            "metasploit get-rk -s" : "Falha. O parâmetro [ -s ] suporta somente criptografia MD5.\n\nUtilize o parâmetro [ -n ] : normal",
            "metasploit get-rk -n" : "Falha. O método [ get-rk ] não obteve sucesso ao tentar quebrar a criptografia SHA256 do sistema root.\n\nUtilize o parâmetro [ -f ] : force\n\nATENÇÃO: O sistema poderá ser afetado.",
            "metasploit get-rk -f" : "Sucesso. Senha capturada com êxito!\n\nSenha: sacola",
            
            //sudo
            "sudo" : "------------------------HELP------------------------\n\nMétodos:\n\t[ su ] : Efetua login como usuário root.\n\t\t[ -p ] : Parâmetro que antecede a senha.\n\nExemplo: [ sudo su -p SENHA ]",
            "sudo --help" : "------------------------HELP------------------------\n\nMétodos:\n\t[ su ] : Efetua login como usuário root.\n\t\t[ -p ] : Parâmetro que antecede a senha.\n\nExemplo: [ sudo su -p SENHA ]",
            "sudo -h" : "------------------------HELP------------------------\n\nMétodos:\n\t[ su ] : Efetua login como usuário root.\n\t\t[ -p ] : Parâmetro que antecede a senha.\n\nExemplo: [ sudo su -p SENHA ]",
            "sudo su -p sacola" : "Mudou para usuário: ROOT.",
        ]
        
        self.consoleRootKeys = [
            //ie-provide-access
            "ie" : "------------------------HELP------------------------\n\nMétodos:\n\t[ access ] : Muda a permissão de acesso da Internet Explorer.\n\t\t[ -deny ] : Bloqueia o acesso.\n\t\t[ -allow ] : Permite o acesso.\n\nExemplo: [ ie access -deny ]",
            "ie --help" : "------------------------HELP------------------------\n\nMétodos:\n\t[ access ] : Muda a permissão de acesso da Internet Explorer.\n\t\t[ -deny ] : Bloqueia o acesso.\n\t\t[ -allow ] : Permite o acesso.\n\nExemplo: [ ie access -deny ]",
            "ie -h" : "------------------------HELP------------------------\n\nMétodos:\n\t[ access ] : Muda a permissão de acesso da Internet Explorer.\n\t\t[ -deny ] : Bloqueia o acesso.\n\t\t[ -allow ] : Permite o acesso.\n\nExemplo: [ ie access -deny ]",
            "ie access -deny" : "Internet Explorer: Permissão de acesso alterada para: BLOQUEADO",
            "ie access -allow" : "Internet Explorer: Permissão de acesso alterada para: PERMITIDO"
        ]
    }
}
