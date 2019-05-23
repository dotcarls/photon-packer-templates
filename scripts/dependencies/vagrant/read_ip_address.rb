def read_ip_address(machine)
    command = "LANG=en ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1 }'"
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