using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Cliente
    {
        private string apellido;
        private string nombre;
        private DateTime fecha_nac;
        private int tipoDocumento;
        private string documento;
        private Calle calle;
        private int altura;
        private Genero genero;

        public Cliente()
        {
            apellido = String.Empty;
            nombre = String.Empty;
            fecha_nac = DateTime.Now;
            tipoDocumento = 0;
            documento = String.Empty;
            calle = null;
            altura = 0;
            genero = null;
        }

        public Cliente(string apellido, string nombre, DateTime fecha_nac, int tipo_documento,
                       string documento, Calle calle, int altura, Genero genero)
        {
            this.apellido = apellido;
            this.nombre = nombre;
            this.fecha_nac = fecha_nac;
            this.tipoDocumento = tipo_documento;
            this.documento = documento;
            this.calle = calle;
            this.altura = altura;
            this.genero = genero;
        }

        public string Apellido
        {
            get { return apellido; }
            set { apellido = value; }
        }
        public string Nombre
        {
            get { return nombre; }
            set { nombre = value; }
        }

        public DateTime FechaNac
        {
            get { return fecha_nac; }
            set { fecha_nac = value; }
        }

        public int TipoDocumento
        {
            get { return tipoDocumento; }
            set { tipoDocumento = value; }
        }

        public string Documento
        {
            get { return documento; }
            set { documento = value; }
        }

        public Calle Calle
        {
            get { return calle; }
            set { calle = value; }
        }

        public int Altura
        {
            get { return altura; }
            set { altura = value; }
        }

        public Genero Genero
        {
            get { return genero; }
            set { genero = value; }
        }
    }
}
