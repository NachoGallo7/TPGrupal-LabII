using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WinFormsTPPrueba.Dominio
{
    internal class DetalleComprobante
    {
        //Butaca Funcion
        public float PrecioHistorico { get; set; }
        public DetalleComprobante(/*Butaca Funcion,*/ float precioHistorico)
        {
            //ButacaFuncion = p;
            PrecioHistorico = precioHistorico;
        }
        public DetalleComprobante()
        {

        }
    }
}
