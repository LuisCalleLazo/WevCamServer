# Imagen de compilación
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copiar los archivos del proyecto
COPY . ./

# Restaurar dependencias y compilar el proyecto
RUN dotnet restore
RUN dotnet publish -c Release -o out

# Imagen de runtime para ejecutar la app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .

# Exponer el puerto en el que la aplicación escucha
EXPOSE 80

# Comando para iniciar la aplicación
ENTRYPOINT ["dotnet", "WebCamServer.dll"]
