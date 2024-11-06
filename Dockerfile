# Usar a imagem oficial do PHP com FPM
FROM php:8.3-fpm

# Instalar dependências do sistema
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Instalar o Composer manualmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Configurar o diretório de trabalho
WORKDIR /var/www/html

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Ajuste de permissões antes de copiar os arquivos
RUN chown -R www-data:www-data /var/www/html

# Copiar os arquivos do projeto para o container
COPY ./src /var/www/html

# Mudar para o usuário www-data antes de criar o projeto Laravel
USER www-data

# Instalar o Laravel
RUN composer create-project --prefer-dist laravel/laravel .

# Voltar para o usuário root para futuras operações
USER root

# Ajuste de permissões
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html

# Expor a porta para o PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]
