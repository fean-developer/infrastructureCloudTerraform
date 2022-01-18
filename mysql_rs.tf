resource "null_resource" "install_mysql_work_ic_arq" {
    triggers = {
        order = azurerm_linux_virtual_machine.vm_work_ic_arq.id
    }
    

    provisioner "remote-exec" {
        connection {
            type        = "ssh"
            user        = var.vm_user
            password    = var.vm_password
            host        = azurerm_public_ip.ip_work_ic_arq.ip_address
        }

        script = "config_mysql.sh"
    }
}