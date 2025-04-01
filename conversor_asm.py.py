"""Conversor de código ASM a binario para el proyecto JericallaEvo."""
import tkinter as tk
from tkinter import filedialog, messagebox

diccionario = {
    "ADD": "00",
    "SUB": "01",
    "LT": "10",
    "SW": "11",
}

def seleccionar_archivo():
    """Abre un diálogo para seleccionar un archivo ASM y muestra su contenido."""
    archivo = filedialog.askopenfilename(filetypes=[("Archivos ASM", "*.asm")])
    if archivo:
        entry_path.delete(0, tk.END)
        entry_path.insert(0, archivo)
        mostrar_contenido(archivo)

def instruccion_a_binario(numero):
    return f"{int(numero):05b}"

def mostrar_contenido(ruta):
    try:
        with open(ruta, "r", encoding="utf-8") as f:
            contenido = f.read()
        text_area.delete("1.0", tk.END)
        text_area.insert(tk.END, contenido)
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo leer el archivo\n{e}")

def convertir_a_binario():
    """ Convierte cada línea del código en binario (ficticio) y guarda en un nuevo archivo """
    ruta = entry_path.get()
    if not ruta:
        messagebox.showwarning("Atención", "Selecciona un archivo primero")
        return

    try:
        with open(ruta, "r", encoding="utf-8") as f:
            lineas = f.readlines()
        
        resultados=[]
        
        for linea in lineas:
            partes = linea.split()
            instruccion = partes[0]
            if instruccion in diccionario:
                binario = diccionario[instruccion]
                if "11" in binario:
                    registros = [instruccion_a_binario(p[1:]) for p in partes[:0:-1]]
                else:
                    registros = [instruccion_a_binario(p[1:]) for p in partes[1:]]
                if "11" in binario:
                    cadena = binario+ "_" + "00000" + "_".join(registros)
                else:
                    cadena = binario+ "_" + "_".join(registros)
                resultados.append(cadena)

        ruta_salida = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Archivo Binario", "*.txt")])
        if ruta_salida:
            with open(ruta_salida, "w", encoding="utf-8") as f:
                f.write("\n".join(resultados))
            messagebox.showinfo("Éxito", f"Archivo binario guardado en:\n{ruta_salida}")
    
    except Exception as e:
        messagebox.showerror("Error", f"No se pudo procesar el archivo\n{e}")

# Crear la ventana principal
root = tk.Tk()
root.title("Conversor ASM a Binario")

# Path del archivo
tk.Label(root, text="Archivo ASM:").pack(pady=5)
entry_path = tk.Entry(root, width=50)
entry_path.pack(padx=10, pady=5)
tk.Button(root, text="Seleccionar", command=seleccionar_archivo).pack(pady=5)

# Área de texto para mostrar el contenido
text_area = tk.Text(root, height=15, width=60)
text_area.pack(padx=10, pady=5)

# Botón para convertir
tk.Button(root, text="Convertir a Binario", command=convertir_a_binario).pack(pady=5)

# Ejecutar
root.mainloop()
