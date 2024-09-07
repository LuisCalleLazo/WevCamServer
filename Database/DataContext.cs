using Microsoft.EntityFrameworkCore;

namespace WebCamServer.Database
{
  
  public class DataContext : DbContext
  {
    public DataContext(DbContextOptions<DataContext> options) : base(options) { }
  }
}