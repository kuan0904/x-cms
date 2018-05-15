using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(MyPublic.Startup))]
namespace MyPublic
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
