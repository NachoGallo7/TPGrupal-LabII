using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Reserva
    {
        public int IdReserva { get; set; }
        public Cliente Ciente { get; set; }
        public DateTime FechaReserva { get; set; }
        public Reserva()
        {

        }
    }
}
