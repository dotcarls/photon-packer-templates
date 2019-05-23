def read_public_ip_address(machine)
    command = "LANG=en dig +short myip.opendns.com @resolver1.opendns.com"
    result  = ""
        
    begin
        # sudo is needed for ifconfig
        machine.communicate.sudo(command) do |type, data|
            result << data if type == :stdout
        end
    rescue
        result = "# NOT-UP"
    end
    
    # the second inet is more accurate as virtualbox has to use eth0 for NAT
    result.chomp.split("\n").last
end