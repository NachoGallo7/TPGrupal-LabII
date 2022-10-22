using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Sala
    {
        public int IdSala { get; set; }
        public int Capacidad { get; set; }
        public TipoSala TipoSala { get; set; }
        public Sala()
        {

        }
    }
}
