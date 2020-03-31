FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as build
WORKDIR /app
ENV ASPNETCORE_URLS http://+:5000;https://+:5001
EXPOSE 5000
EXPOSE 5001
ENTRYPOINT [ "dotnet", "watch", "run", "--no-restore", "--urls", "https://0.0.0.0:5000"]

# copy csproj and restore
COPY TestApi/*.csproj ./testapi/
RUN cd ./testapi/ && dotnet restore 

# copy all files and build
COPY TestApi/. ./testapi/
WORKDIR /app/testapi
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as runtime
WORKDIR /app
COPY --from=build /app/testapi/out ./
ENTRYPOINT [ "dotnet", "TestApi.dll" ]