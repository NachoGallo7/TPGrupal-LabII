using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Barrio
    {
        private string nombreBarrio;
        private int idBarrio;
        private List<Calle> calles;
        private Localidad localidad;

        public Barrio()
        {
            nombreBarrio = String.Empty;
            idBarrio = 0;
            calles = new List<Calle> ();
            localidad = null;
        }

        public Barrio(string nombreBarrio, int idBarrio, List<Calle> calles, Localidad localidad)
        {
            this.nombreBarrio = nombreBarrio;
            this.idBarrio = idBarrio;
            this.calles = calles;
            this.localidad = localidad;
        }

        public string NombreBarrio
        {
            get { return nombreBarrio; }
            set { nombreBarrio = value; }
        }

        public int IdBarrio { get; set; }
        public List<Calle> Calles { get; set; }
        public Localidad Localidad { get; set; }
    }
}
