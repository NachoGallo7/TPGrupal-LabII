using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Localidad
    {
        private string nombreLocalidad;
        private int idLocalidad;
        private List<Barrio> barrios;
        private Provincia provincia;

        public Localidad()
        {
            nombreLocalidad = String.Empty;
            idLocalidad = 0;
            barrios = new List<Barrio>();
            provincia = null;
        }

        public Localidad(string nombreLocalidad, int idLocalidad, List<Barrio> barrios, Provincia provincia)
        {
            this.nombreLocalidad = nombreLocalidad;
            this.idLocalidad = idLocalidad;
            this.barrios = barrios;
            this.provincia = provincia;
        }

        public string NombreLocalidad { get; set; }
        public int IdLocalidad { get; set; }
        public List<Barrio> Barrios { get; set; }
        public Provincia Provincia{ get; set; }
    }
}
