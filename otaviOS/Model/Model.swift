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
    
    static let isDebugging: Bool = false
    
    //DEBUG OPTIONS--------------------------
    var isSoundMuted: Bool = false || isDebugging
    var isConsoleCracked: Bool = false || isDebugging
    var hasRootAccess: Bool = false || isDebugging
    var hasInternetExplorerAccess: Bool = false || isDebugging
    var skipStartupAnimation: Bool = false || isDebugging
    //---------------------------------------
    
    var consoleKeys: [String : String]
    var consoleRootKeys: [String : String]
    var consoleInvalidCommandError: String
    var consoleRootRequiredError: String
    var consoleFontColor: UIColor
    var consoleBackgroundColor: UIColor
    
    var screenBrightness: CGFloat
    
    func resetOptions() {
        self.isSoundMuted = false || Model.isDebugging
        self.isConsoleCracked = false || Model.isDebugging
        self.hasRootAccess = false || Model.isDebugging
        self.hasInternetExplorerAccess = false || Model.isDebugging
        self.skipStartupAnimation = false || Model.isDebugging
        
        self.consoleFontColor = .white
        self.consoleBackgroundColor = .black
    }
    
    func getConsoleHeader() -> String {
        return "IPHONE_XR:~ " + (self.hasRootAccess ? "root#" : "guest$") + "> "
    }
    
    private init() {
        self.consoleInvalidCommandError = "O comando é inválido. Utilize o comando [ help ]"
        self.consoleRootRequiredError = "Erro ao executar comando, o usuário ROOT é necessário."
        self.consoleFontColor = .white
        self.consoleBackgroundColor = .black
        
        self.screenBrightness = UIScreen.main.brightness
        
        self.consoleKeys = [
            //help
            "" : """
            Utilize o comando [ help ]
            """,
            
            "help" : """
            ------------------------HELP------------------------
            
            Comandos:
                [ exit ]
                [ clear ]
                [ color ]
                [ device ]
                [ otavio ] - Em construção
                [ metasploit ]
                [ sudo ]
                [ ie ] - root necessário
            """,
            //
            
            //exit
            "exit" : """
            O console irá fechar em instantes.
            """,
            
            "exit --help" : """
            ------------------------HELP------------------------
            
            O comando finaliza o processo do console.
            """,
            
            "exit -h" : """
            ------------------------HELP------------------------
            
            O comando finaliza o processo do console.
            """,
            //
            
            //clear
            "clear" : "",
            
            "clear --help" : """
            ------------------------HELP------------------------
            
            O comando limpa o console.
            """,
            
            "clear -h" : """
            ------------------------HELP------------------------
            
            O comando limpa o console.
            """,
            //
            
            //color
            "color" : """
            ------------------------HELP------------------------
            
            O comando altera a cor do texto do console.
            OBS: Caso a cor da fonte seja a mesma da cor de fundo, o otaviOS© ajustará as cores automaticamente para melhor vizualização.
            
            Métodos:
                [ text ] : Altera a cor do texto
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                [ bg ] : Altera a cor do fundo
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                Exemplo: [ color text -green ]
            """,
            
            "color --help" : """
            ------------------------HELP------------------------
            
            O comando altera a cor do texto do console.
            OBS: Caso a cor da fonte seja a mesma da cor de fundo, o otaviOS© ajustará as cores automaticamente para melhor vizualização.
            
            Métodos:
                [ text ] : Altera a cor do texto
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                [ bg ] : Altera a cor do fundo
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                Exemplo: [ color text -green ]
            """,
            
            "color -h" : """
            ------------------------HELP------------------------
            
            O comando altera a cor do texto do console.
            OBS: Caso a cor da fonte seja a mesma da cor de fundo, o otaviOS© ajustará as cores automaticamente para melhor vizualização.
            
            Métodos:
                [ text ] : Altera a cor do texto
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                [ bg ] : Altera a cor do fundo
                    [ -white ] : Branco
                    [ -green ] : Verde
                    [ -blue ] : Azul
                    [ -red ] : Vermelho.
            
                Exemplo: [ color text -green ]
            """,
            
            "color text -white" : "",
            "color text -green" : "",
            "color text -blue" : "",
            "color text -red" : "",
            "color bg -white" : "",
            "color bg -green" : "",
            "color bg -blue" : "",
            "color bg -red" : "",
            //
            
            //otavio
            "otavio" : "comando em construção",
            "otavio --help" : "comando em construção",
            "otavio -h" : "comando em construção",
            //
            
            //metasploit
            "metasploit" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ get-rk ] : Retorna a senha do root.
                    [ -s ] : soft
                    [ -n ] : normal
                    [ -f ] : force
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ get-rk ] : Retorna a senha do root.
                    [ -s ] : soft
                    [ -n ] : normal
                    [ -f ] : force
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ get-rk ] : Retorna a senha do root.
                    [ -s ] : soft
                    [ -n ] : normal
                    [ -f ] : force
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit get-rk": """
            Erro. Defina um parâmetro para o método [ get-rk ]
            
            Exemplo: [ metasploit get-rk -s ]
            """,
            
            "metasploit get-rk -s" : """
            Falha. O parâmetro [ -s ] suporta somente criptografia MD5.
            
            Utilize o parâmetro [ -n ] : normal
            """,
            
            "metasploit get-rk -n" : """
            Falha. O método [ get-rk ] não obteve sucesso ao tentar quebrar a criptografia SHA256 do sistema root.
            
            Utilize o parâmetro [ -f ] : force
            
            ATENÇÃO: O sistema poderá ser afetado.
            """,
            
            "metasploit get-rk -f" : """
            Sucesso. Senha capturada com êxito!
            
            Senha: sacola
            """,
            //
            
            //sudo
            "sudo" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ su ] : Efetua login como usuário root.
                    [ -p ] : Parâmetro que antecede a senha.
            
            Exemplo: [ sudo su -p ***** ]
            """,
            
            "sudo --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ su ] : Efetua login como usuário root.
                    [ -p ] : Parâmetro que antecede a senha.
            
            Exemplo: [ sudo su -p ***** ]
            """,
            
            "sudo -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ su ] : Efetua login como usuário root.
                    [ -p ] : Parâmetro que antecede a senha.
            
            Exemplo: [ sudo su -p ***** ]
            """,
            
            "sudo su -p sacola" : """
            Mudou para usuário: ROOT.
            """,
            //
            
            //device
            "device" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ info ] : Retorna as informações do dispositivo, sistema e bateria.
            """,
            
            "device --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ info ] : Retorna as informações do dispositivo, sistema e bateria.
            """,
            
            "device -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ info ] : Retorna as informações do dispositivo, sistema e bateria.
            """,
            
            "device info" : """
                            Dispositivo:
                                Nome: \(UIDevice.current.name)
                                Modelo: \(UIDevice.current.model)
                                Id: \(UIDevice.current.identifierForVendor!.uuidString)
                                
                            Sistema:
                                Nome: \(UIDevice.current.systemName)
                                Versão: \(UIDevice.current.systemVersion)
                                
                            Bateria:
                                Percentual de carga: \(UIDevice.current.batteryLevel * 100)%
                            """,
        ]
        
        self.consoleRootKeys = [
            //ie
            "ie" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ access ] : Muda a permissão de acesso da Internet Explorer.
                    [ -deny ] : Bloqueia o acesso.
                    [ -allow ] : Permite o acesso.
            
            Exemplo: [ ie access -deny ]
            """,
            
            "ie --help" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ access ] : Muda a permissão de acesso da Internet Explorer.
                    [ -deny ] : Bloqueia o acesso.
                    [ -allow ] : Permite o acesso.
            
            Exemplo: [ ie access -deny ]
            """,
            
            "ie -h" : """
            ------------------------HELP------------------------
            
            Métodos:
                [ access ] : Muda a permissão de acesso da Internet Explorer.
                    [ -deny ] : Bloqueia o acesso.
                    [ -allow ] : Permite o acesso.
            
            Exemplo: [ ie access -deny ]
            """,
            
            "ie access -deny" : """
            Internet Explorer: Permissão de acesso alterada para: BLOQUEADO
            """,
            
            "ie access -allow" : """
            Internet Explorer: Permissão de acesso alterada para: PERMITIDO
            """
        ]
    }
}
