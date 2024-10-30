using System.ComponentModel;
using Microsoft.EntityFrameworkCore;
using WebCamServer.Models;


namespace usr_service.Data
{
  public class DataContext : DbContext
  {
    public DataContext(DbContextOptions<DataContext> options) : base(options) { }


    // USER AND AUTHENTICATION
    public DbSet<User> Users { get; set; }
    public DbSet<UserInfo> UserInfos { get; set; }
    public DbSet<Admin> Admins { get; set; }
    public DbSet<Seeker> Seekers { get; set; }
    public DbSet<Token> Tokens { get; set; }
    public DbSet<Contacts> Contacts { get; set; }
    
    // Camera Video
    public DbSet<Camera> Cameras {get; set;}
    public DbSet<FoundVideo> FoundVideos { get; set; }
    public DbSet<Notification> Notifications { get; set; }
    public DbSet<Missing> Missings { get; set; } 
    
    private string varchar_name = "varchar(50)";
    private string varchar_desc = "varchar(200)";
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
      
      modelBuilder.Entity<User>(ur => {
        ur.HasKey(u => u.Id);
        ur.HasIndex(u => u.Name)
          .IsUnique();

        ur.HasIndex(u => u.Email)
          .IsUnique();
          
        ur.HasOne( p => p.UserInfo)
          .WithOne( p => p.User)
          .HasForeignKey<User>( p => p.UserInfoId);
        // ur.HasData(UserSeed.GetSeed());
      });
      
      modelBuilder.Entity<UserInfo>(tb => {
        tb.HasKey( p => p.Id);
        
        // tb.HasData(UserInfoSeed.GetFakerSeed().Generate(161));
      });

      modelBuilder.Entity<Admin>(tb => {
        tb.HasKey( p => p.Id);
        
        tb.HasOne( p => p.User)
          .WithOne( p => p.Admin)
          .HasForeignKey<Admin>( p => p.UserId);
        // tb.HasData(AdminSeed.GetSeed());
      });
      
      modelBuilder.Entity<Seeker>(tb => {
        tb.HasKey( p => p.Id);
        
        tb.HasOne( p => p.User)
          .WithOne( p => p.Seeker)
          .HasForeignKey<Seeker>( p => p.UserId);
        // tb.HasData(AdminSeed.GetSeed());
      });
      
      modelBuilder.Entity<Token>(tb => {
        tb.HasKey( p => p.Id);
        
        tb.HasOne( p => p.User)
          .WithMany( p => p.Tokens)
          .HasForeignKey( p => p.UserId)
          .IsRequired();
      });

      modelBuilder.Entity<Contacts>(tb => {
        tb.HasKey(p => p.Id);

        tb.HasOne( p => p.Seeker)
          .WithMany( p => p.Contacts)
          .HasForeignKey( p => p.SeekerId)
          .IsRequired();
      });

      
      modelBuilder.Entity<Camera>(tb => {
        tb.HasKey(p => p.Id);
      });
      
      modelBuilder.Entity<FoundVideo>(tb => {
        tb.HasKey(p => p.Id);

        tb.HasOne( p => p.Camera)
          .WithMany( p => p.FoundVideos)
          .HasForeignKey( p => p.CameraId)
          .IsRequired();
          
        tb.HasOne( p => p.Missing)
          .WithMany( p => p.FoundVideos)
          .HasForeignKey( p => p.MissingId)
          .IsRequired();
      });

      modelBuilder.Entity<Notification>(tb => {
        tb.HasKey( p => p.Id);
        
        tb.HasOne( p => p.User)
          .WithMany( p => p.Notifications)
          .HasForeignKey( p => p.UserId)
          .IsRequired();

        tb.Property( p => p.Title)
          .IsRequired();

        tb.Property( p => p.Type)
          .IsRequired();
          
        tb.Property( p => p.Description)
          .IsRequired(false);
      });

      
      modelBuilder.Entity<Missing>(tb => {
        tb.HasKey(p => p.Id);
        
        tb.HasOne( p => p.Seeker)
          .WithMany( p => p.Missings)
          .HasForeignKey( p => p.SeekerId)
          .IsRequired();
      });

    }
  }
}