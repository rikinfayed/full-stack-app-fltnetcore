using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ToponymyWebApi.Data;
using ToponymyWebApi.Models;

namespace ToponymyWebApi.Controllers;

[ApiController]
[Route("Api/[controller]")]
public class PlacesController : ControllerBase
{
    private readonly PlaceDbContext _placeDbContext;

    public PlacesController(PlaceDbContext placeDbContext) {
        _placeDbContext = placeDbContext;
    }

    [HttpGet]
    public async Task<IActionResult> GetAsync()
    {
        var places = await _placeDbContext.Places.ToListAsync();
        return Ok(places);
    }

    [HttpGet("Show")]
    //[Route("get-place-by-id")]
    public async Task<IActionResult> GetPlaceByIdAsync(int id)
    {
        var place = await _placeDbContext.Places.FindAsync(id);
        return Ok(place);
    }

    [HttpPost("Store")]
    public async Task<IActionResult> PostAsync(Places place)
    {
        _placeDbContext.Places.Add(place);
        await _placeDbContext.SaveChangesAsync();
        return Created($"get-place-by-id?id={place.Id}", place);
    }

    [HttpPut("Update")]
    public async Task<IActionResult> PutAsync(Places placeToUpDate)
    {
        _placeDbContext.Places.Update(placeToUpDate);
        await _placeDbContext.SaveChangesAsync();
        return NoContent();
    }

    [Route("Detele/{id}")]
    [HttpDelete]
    public async Task<IActionResult> DeleteAsync(int id)
    {
        var placeToDelete = await _placeDbContext.Places.FindAsync(id);
        if(placeToDelete == null) {
            return NotFound();
        }
        _placeDbContext.Places.Remove(placeToDelete);
        await _placeDbContext.SaveChangesAsync();
        return NoContent();
    }
}