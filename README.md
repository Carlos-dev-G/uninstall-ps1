### **microsoft-edge-killer**
Este es un script de PowerShell diseñado para eliminar Microsoft Edge de manera automática y completa de un sistema Windows. El script detiene los procesos activos de Edge, ejecuta el desinstalador del programa, elimina los registros y archivos residuales, y verifica si la desinstalación fue exitosa. Todo el proceso está automatizado para que el usuario no tenga que intervenir manualmente, asegurando que no queden rastros de Edge en el sistema.

```ps1
iex (iwr 'https://raw.githubusercontent.com/Carlos-dev-G/microsoft-edge-killer/refs/heads/main/scripts/script.ps1' -UseBasicParsing).Content
```

### **Índice:**
1. **Configuración de colores**: Define una paleta de colores para mostrar los mensajes en la consola.
2. **Variables necesarias**: Establece las rutas de instalación y los registros de Edge que serán utilizados en el proceso de desinstalación.
3. **Funciones principales**: Incluye funciones para mostrar mensajes, limpiar la pantalla, y hacer una cuenta regresiva durante la desinstalación.
4. **Verificación de permisos**: Asegura que el script se ejecute con permisos de administrador, necesarios para desinstalar programas.
5. **Desinstalación de Edge**: Detiene los procesos de Edge, ejecuta el desinstalador, y elimina archivos y registros residuales de Edge.
6. **Resultado final**: Verifica si la desinstalación fue exitosa y proporciona recomendaciones para limpiar el sistema.
