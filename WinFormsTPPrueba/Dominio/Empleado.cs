using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Empleado
    {
        public int IdEmpleado { get; set; }
        public string Apellido { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaNac { get; set; }
        public DateTime FechaIngreso { get; set; }
        //public TipoDoc TipoDocumento { get; set; }
        public string NroDocumento { get; set; }
        //public Calle Calle { get; set; }
        public int Altura { get; set; }
        //public Genero Genero { get; set; }
        //ContactoEmpleado
        public Empleado()
        {

        }
    }
}
