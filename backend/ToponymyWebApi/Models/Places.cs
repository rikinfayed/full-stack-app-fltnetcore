using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ToponymyWebApi.Models;
[Table("place")]
public class Places
{
    [Key, DatabaseGenerated(DatabaseGeneratedOption.Identity)] 
    [Column("id")]
    public int Id { get; set; }

    [Column("name_owner")]
    public string? NameOwner { get; set; }

    [Column("place")]
    public string? Place {get; set;}

    [Column("address")]
    public string? Address { get; set; }

    [Column("type")]
    public string? type { get; set; }

    public DateOnly date { get; set; }

    [Column("latitude")]
    public double Latitude { get; set; }
    
    [Column("longitude")]
    public double Longitude { get; set; }

    [Column("is_deleted")]
    public Boolean isDeleted { get; set;} = false;
}