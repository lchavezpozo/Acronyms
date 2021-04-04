# Cree una aplicación que pueda usarse para obtener el significado de las siglas.

## Criterios de aceptación funcional
1. El usuario puede introducir un acrónimo o una inicial.
2. A continuación, se presenta al usuario una lista de los significados correspondientes
## Criterios de aceptación adicionales
Así mismo  para dicha prueba técnica me tome la necesidad de adicionar los siguientes criterios de aceptación :

3. Validar que el buscador no acepte espacios en blanco debido a que los acrónimos no cuentan con espacios.
4. Evitar generar búsquedas con menos de un carácter  (Se verifico que el Api solo busca a partir de 2 caracteres).
5. Evitar llamar al servicio por cada nuevo carácter ingresado, incluir un tiempo mínimo de espera de tipeo (300 milisegundos) para comenzar con la búsqueda.
6. Si el servicio envía resultados vacíos mostrar en una vista que no se encuentro resultados.
7. Mostrar una alerta con un mensaje genérico  para errores del API.(el API no cuenta con documentación sobre errores)

## Detalles técnicos
1. Utilice la API disponible aquí para obtener el significado de un acrónimo / inicial: • http://www.nactem.ac.uk/software/acromine/rest.html

# Resultados
## Arquitectura
Para este ejercicio se considero la arquitectura MVVM + Coordinators asi mismo para el diseño de las vistas se considero no utilizar storyboard 

![alt text](https://assets.website-files.com/5e305a6cb7083222527a89cc/5e3adace3eccb56cfcce6e42_1*dVJv23ChJixjayLKzL9HRg.png)
## Estructura de Carpetas

| Carpetas | Información |
| ------ | ------ |
| Environments | En esta carpeta se almacena las variables de ambiente y Settings |
| Core | En esta carpeta se alamcena Extensones, protocolos, coordinators y Localizables  |
| Models |  En esta carpeta se alamcena los modelos |
| Networking | En esta carpeta se almacena todo lo realacionado con el manejo de Red |
| CommonComponents |  En esta carpeta se almacena vistas comunes para reutilizarlo en los modulos |
| Repositories | En esta carpeta se almacena los repostiorios del app |
| Modules | En esta carpeta se encuentra los modulos de la aplicación, un modulo hace referencia a una patalla |
| SuportFiles |  Se almacena archivos de soporte - Assets, LaunchScreen, AppDdelegate y SceneDelegate |

## Schemes
Al seleccionar una Scheme tambien se cambia automaticamente el ambiente a donde se esta apuntado según archivo de configuración(xcconfig)

| Schemes | Información |  Archivo de configuración |
| ------ | ------ | ------ |
| Dev | Scheme asginado para el ambiente de desarrollo | Acronyms/Environments/Configs/Dev.xcconfig |
| Prod | Scheme asignado para el ambiente de producción | Acronyms/Environments/Configs/Prod.xcconfig |

## Localizables - Multi-idioma
Se considero los siguientes idiomas:
| idioma | ubicación |
| ------ | ------ |
| Ingles | Acronyms/Core/Localizables/Localizable.strings |
| Español | Acronyms/Core/Localizables/Localizable.strings |

## Setting - Cambio de ambientes en caliente
Se agrego un Setting.bundle para facilitar el cambio de ambientes en caliente.

![alt text](https://media.giphy.com/media/f2wnWy9Pu7hkSabHjP/giphy.gif)


## Mockoon - https://mockoon.com
Se considero usar la herramienta Mockoon para realizar pruebas en local y no depender del API, asi mismo facilita encontrar unhapies

- Se adjunta mockoon.json para importar el proyecto en mockoon : https://drive.google.com/file/d/1ny1PG4jnPvJOMMkhpL3s9sriWYyaHG0R/view?usp=sharing

![alt text](https://media.giphy.com/media/Zh0luKb7seLQxR96H1/giphy.gif)
