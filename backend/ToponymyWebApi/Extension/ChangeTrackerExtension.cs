using Microsoft.EntityFrameworkCore.ChangeTracking;
using Microsoft.EntityFrameworkCore;
using ToponymyWebApi.Models;

namespace ToponymyWebApi.Extension;

public static class ChangeTrackerExtenstion
{
    public static void SetAuditProperties(this ChangeTracker changeTracker)
    {
        changeTracker.DetectChanges();
        IEnumerable<EntityEntry> entities = changeTracker.Entries().Where(t => t.Entity is Places && t.State is EntityState.Deleted);

        if(entities.Any()){
            foreach(EntityEntry entry in entities)
            {
                Places entity = (Places)entry.Entity;
                entity.isDeleted = true;
                entry.State = EntityState.Modified;
            }
        }
    }
}