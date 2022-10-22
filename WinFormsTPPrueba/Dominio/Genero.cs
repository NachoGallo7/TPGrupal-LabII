using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Genero
    {
        private string nombreGenero;
        private int idGenero;
        
        public Genero()
        {
            nombreGenero = String.Empty;
            idGenero = 0;
        }

        public Genero(string nombreGenero, int idGenero)
        {
            this.nombreGenero = nombreGenero;
            this.idGenero = idGenero;
        }

        public string NombreGenero { get; set; }
        public int IdGenero { get; set; }
    }
}
