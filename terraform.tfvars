# terraform.tfvars.example
# Propósito: archivo de ejemplo para definir valores de variables de Terraform.
# Copiar este archivo a terraform.tfvars y modificar con tus propios valores.

# Puerto base para los contenedores Nginx.
# Ejemplo: si nginx_container_count = 3 y base = 8080 → contenedores en 8080, 8081 y 8082
nginx_base_port = 8080

# Número de contenedores Nginx que se desplegarán.
nginx_container_count = 3
