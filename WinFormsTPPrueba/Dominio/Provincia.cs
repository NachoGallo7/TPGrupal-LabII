using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Provincia
    {
        private string nombreProvincia;
        private int idProvincia;
        private List<Localidad> localidades;

        public Provincia()
        {
            nombreProvincia = String.Empty;
            idProvincia = 0;
            localidades = new List<Localidad>();
        }

        public Provincia(string nombreProvincia, int idProvincia, List<Localidad> localidades)
        {
            this.nombreProvincia = nombreProvincia;
            this.idProvincia = idProvincia;
            this.localidades = localidades;
        }

        public string NombreProvincia { get; set; }
        public int IdProvincia { get; set; }
        public List<Localidad> Localidades { get; set; }
    }
}
