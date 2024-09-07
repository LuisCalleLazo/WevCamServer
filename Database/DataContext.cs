using Microsoft.EntityFrameworkCore;
using WebCamServer.Models;

namespace WebCamServer.Database
{
  
  public class DataContext : DbContext
  {
    public DataContext(DbContextOptions<DataContext> options) : base(options) { }
    public DbSet<User> User {get; set;}
  }
}