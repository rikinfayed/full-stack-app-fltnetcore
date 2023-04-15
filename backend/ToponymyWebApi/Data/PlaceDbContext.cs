using ToponymyWebApi.Models;
using Microsoft.EntityFrameworkCore;
using ToponymyWebApi.Extension;

namespace ToponymyWebApi.Data;

public class PlaceDbContext : DbContext
{

    public PlaceDbContext(DbContextOptions<PlaceDbContext> context) : base(context)
    {

    }
    
    /*
     * Soft Deletion::Soft Deletion
     * tidak menampilkan entity dengan status isDeleted = true
     */
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Places>().HasQueryFilter(p => !p.isDeleted);
    }

    /*
     * Soft Delection::Override Entity State || Properties
     * merubah operation Remove menjadi Modified, dan isDeleted = true
     */
    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        ChangeTracker.SetAuditProperties();
        return await base.SaveChangesAsync(cancellationToken);
    }

    public DbSet<Places> Places {get; set;}  = null!;
}