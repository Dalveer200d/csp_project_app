import 'package:flutter/material.dart';

class PurificationPage extends StatelessWidget {
  const PurificationPage({super.key});

  // Helper widget for consistent section headings
  Widget _buildSectionHeader(String title, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for sub-headings
  Widget _buildSubHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  // Helper widget for body text
  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, height: 1.5),
      textAlign: TextAlign.justify,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Purification"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- IMAGE ---
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://i.pinimg.com/736x/44/5e/df/445edf1bab6d4a244a55dfc3597294aa.jpg",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox(
                    height: 220,
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),

            // --- WHY PURIFY WATER? (EXPANDED) ---
            _buildSectionHeader(
              "Why is Purification Non-Negotiable?",
              const Color(0xFF303F9F),
              Icons.warning_amber,
            ),
            _buildBodyText(
              "Water, the 'universal solvent,' rarely exists in its pure H₂O form in nature. As it flows over land and seeps through the ground, it dissolves and carries various substances. Purification is the process of removing these contaminants to make water safe and palatable for its intended use, especially drinking. Without it, we are exposed to a wide range of invisible dangers.",
            ),

            _buildSubHeader("1. Biological Contaminants (Microbes)"),
            _buildBodyText(
              "These are living organisms invisible to the naked eye that cause severe waterborne diseases.\n"
              "• **Bacteria:** Such as *Salmonella* (Typhoid fever), *Vibrio cholerae* (Cholera), *E. coli*, and *Shigella* (Dysentery).\n"
              "• **Viruses:** Including Hepatitis A, Rotavirus (severe diarrhea, especially in infants), and Norovirus.\n"
              "• **Protozoa:** Parasites like *Giardia lamblia* (Giardiasis) and *Cryptosporidium*, which are notoriously resistant to chlorine.",
            ),

            _buildSubHeader("2. Chemical Contaminants"),
            _buildBodyText(
              "These are dissolved and inorganic/organic compounds that can be toxic or cause long-term health problems.\n"
              "• **Heavy Metals:** Lead (from old pipes), Arsenic (from groundwater), Mercury, and Cadmium (from industrial waste) are neurotoxins and carcinogens.\n"
              "• **Pesticides & Herbicides:** Runoff from agricultural areas contaminates rivers and wells.\n"
              "• **Nitrates/Nitrites:** From fertilizers and sewage; particularly dangerous for infants (causes 'Blue Baby Syndrome').\n"
              "• **Total Dissolved Solids (TDS):** Refers to all dissolved salts like calcium, magnesium, and sodium. High TDS (above 500 ppm) imparts a salty or brackish taste and can be harmful.",
            ),

            _buildSubHeader("3. Physical & Aesthetic Contaminants"),
            _buildBodyText(
              "These affect the water's appearance, taste, and smell.\n"
              "• **Turbidity:** Cloudiness caused by suspended particles like silt, sand, or clay. While not always harmful itself, it can shield microbes from disinfectants.\n"
              "• **Taste & Odor:** Often caused by chlorine (added for disinfection) or organic compounds.",
            ),

            // --- TRADITIONAL METHODS (EXPANDED) ---
            _buildSectionHeader(
              "Traditional & Basic Methods",
              Colors.brown,
              Icons.history_edu,
            ),

            _buildSubHeader("Boiling"),
            _buildBodyText(
              "• **Science:** The oldest method. Heat denatures the essential proteins and enzymes of all pathogens (bacteria, viruses, protozoa), killing them. Water must be brought to a **rolling boil for at least 1 full minute** (or 3 minutes at altitudes above 6,500 ft).\n"
              "• **Pros:** 100% effective against all microbes. Simple and accessible.\n"
              "• **Cons:** Does *not* remove chemical, heavy metal, or dissolved solid (TDS) contamination. It also won't clear up turbidity. It is energy-intensive (requires fuel) and labor-intensive.",
            ),

            _buildSubHeader("Slow Sand Filtration (SSF)"),
            _buildBodyText(
              "• **Science:** This is a low-tech, highly effective community-level filter. Water percolates slowly through a bed of sand. The magic happens in the top layer, which develops a biological film called the **'schmutzdecke'** (German for 'dirt cover'). This biofilm is a living ecosystem of algae and bacteria that actively consume pathogens, while the sand below traps physical particles.\n"
              "• **Pros:** Highly effective (99.9% pathogen removal), low cost, no chemicals needed.\n"
              "• **Cons:** Very slow flow rate. Requires a large area. The 'schmutzdecke' takes weeks to mature.",
            ),

            _buildSubHeader("Solar Disinfection (SODIS)"),
            _buildBodyText(
              "• **Science:** Uses two components of sunlight. Clear, plastic (PET) bottles are filled with water and placed in direct sun for at least 6 hours. **UV-A radiation** in sunlight damages the DNA of microbes. **Infrared radiation** (heat) also pasteurizes the water. The combination is a powerful disinfectant.\n"
              "• **Pros:** Free, zero-energy, and eco-friendly.\n"
              "• **Cons:** Only works for low-turbidity water (not cloudy), is time-consuming, and is weather-dependent.",
            ),

            // --- MODERN METHODS (EXPANDED) ---
            _buildSectionHeader(
              "Modern Purification Technologies",
              Colors.blueAccent,
              Icons.biotech,
            ),

            _buildSubHeader("Reverse Osmosis (RO)"),
            _buildBodyText(
              "• **Science:** The heart of an RO system is a semi-permeable membrane with microscopic pores (approx. 0.0001 micron). Normal osmosis is when water moves from a less salty solution to a more salty one. RO uses high pressure to *reverse* this, forcing water *against* the concentration gradient. Only pure water molecules can pass, leaving behind dissolved salts, heavy metals, and microbes.\n"
              "• **Removes:** TDS, heavy metals (Arsenic, Lead), salts, bacteria, viruses.\n"
              "• **Pros:** The most comprehensive method for removing dissolved solids. Essential for high-TDS (brackish) water.\n"
              "• **Cons:** **High water wastage** (3-4 liters of 'reject water' for 1 liter pure). **Removes beneficial minerals** (calcium, magnesium), making water acidic (often fixed with a 'mineralizer' cartridge). Requires electricity and high maintenance.",
            ),

            _buildSubHeader("Ultraviolet (UV) Purification"),
            _buildBodyText(
              "• **Science:** An in-line system where water flows past a lamp emitting UV-C light (at a 254-nanometer wavelength). This light is a powerful germicide. It penetrates the cell walls of microbes and scrambles their DNA/RNA, making it impossible for them to reproduce and cause disease. They are "
              "**inactivated**, not physically removed.\n"
              "• **Removes:** *Only* microbes (bacteria, viruses, protozoa). It is a disinfectant, not a filter.\n"
              "• **Pros:** Extremely fast, chemical-free, does not alter water's taste or smell.\n"
              "• **Cons:** **Does not remove ANY physical or chemical contaminants.** Water *must* be pre-filtered and clear; turbidity (cloudiness) shields microbes from the UV light, rendering it useless. Requires electricity.",
            ),

            _buildSubHeader("Activated Carbon Filtration"),
            _buildBodyText(
              "• **Science:** Uses **adsorption** (not absorption). Carbon is 'activated' by steam or heat, creating a vast network of pores. This gives it a massive surface area (one gram can have the surface area of a football field). As water passes through, chemical contaminants and taste/odor compounds stick to this surface like a magnet.\n"
              "• **Removes:** Chlorine, pesticides, herbicides, industrial solvents (VOCs), and compounds that cause bad taste and smell.\n"
              "• **Pros:** Vastly improves water's taste and odor. Very common pre/post-filter.\n"
              "• **Cons:** Does *not* remove microbes, heavy metals, or dissolved solids (TDS). The filter gets saturated and must be replaced regularly.",
            ),

            _buildSubHeader("Ultrafiltration (UF)"),
            _buildBodyText(
              "• **Science:** Another membrane filter, but with larger pores (approx. 0.01 micron) than RO. It uses standard household water pressure to push water through a hollow fiber membrane, physically blocking contaminants based on size.\n"
              "• **Removes:** All bacteria, protozoa, viruses (most), silt, and turbidity.\n"
              "• **Pros:** Works **without electricity**. **No water wastage.** Retains essential minerals, so water tastes natural.\n"
              "• **Cons:** **Does not remove dissolved solids (TDS) or heavy metals.** Not suitable for high-TDS water.",
            ),

            // --- ENVIRONMENTAL CONSIDERATIONS (EXPANDED) ---
            _buildSectionHeader(
              "Environmental & Sustainability Issues",
              Colors.green,
              Icons.eco,
            ),
            _buildSubHeader("The 'Reject Water' Problem"),
            _buildBodyText(
              "RO purifiers are the biggest offenders. The reject water is a highly concentrated brine of all the contaminants (salts, arsenic, etc.) that were removed. Simply dumping this down the drain increases the salinity of groundwater, harms aquatic life, and pollutes the local water table, creating a vicious cycle. This wastewater should ideally be used for mopping or flushing, but never for consumption or watering plants.",
            ),
            _buildSubHeader("Energy & Material Waste"),
            _buildBodyText(
              "RO and UV systems require a constant electricity supply, contributing to a carbon footprint. Furthermore, all modern purifiers rely on disposable plastic filter cartridges. These sediment filters, carbon blocks, and RO membranes are complex, non-biodegradable waste items that end up in landfills.",
            ),
            _buildSubHeader("The Eco-Friendly Future"),
            _buildBodyText(
              "The most sustainable solutions are often low-tech and context-specific. **Bio-sand filters** (a modern, household version of SSF) are highly effective, built from local materials, and require no electricity. The best approach is often a **holistic one**: reduce pollution at the source, harvest rainwater to get purer source water, and then use the *minimum necessary* purification (e.g., UF + UV) instead of defaulting to a water-wasting RO system.",
            ),
          ],
        ),
      ),
    );
  }
}
