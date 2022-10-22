using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class Comprobante
    {
        public int IdComprobante { get; set; }
        public Empleado Empleado { get; set; }
        public Cliente Cliente { get; set; }
        public DateTime Fecha { get; set; }
        public DateTime Hora { get; set; }
        //TipoCompra
        public double Descuento { get; set; }

        public List<DetalleComprobante> Detalles { get; set; }

        public Comprobante()
        {
            Detalles = new List<DetalleComprobante>();
        }

        public void AgregarDetalle(DetalleComprobante detalle)
        {
            Detalles.Add(detalle);
        }

        public void QuitarDetalle(int indice)
        {
            Detalles.RemoveAt(indice);
        }
    }
}
