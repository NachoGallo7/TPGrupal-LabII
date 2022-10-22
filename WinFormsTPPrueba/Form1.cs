using System.Windows.Forms;

namespace WinFormsTPPrueba
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TestForm test = new TestForm();
            test.Show();
        }
    }
}