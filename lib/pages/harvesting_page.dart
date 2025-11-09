import 'package:flutter/material.dart';

class HarvestingPage extends StatelessWidget {
  const HarvestingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Harvesting & Conservation"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://i.pinimg.com/1200x/c7/79/e8/c779e8444b66f41fc104bdb2ddd20fe9.jpg",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                // Added loading and error builders for robustness
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
            const SizedBox(height: 16),
            const Text(
              "💧 What is Water Harvesting?",
              style: TextStyle(
                fontSize: 24, // Slightly larger
                fontWeight: FontWeight.bold,
                color: Color(0xFF004D40), // Dark Teal
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Water harvesting is the simple, age-old practice of collecting, storing, and conserving local rainwater and surface runoff for future use. As opposed to relying on large-scale dams or distant rivers, it focuses on capturing water where it falls.\n\n"
              "In India, this is not a new concept. From the 'Johads' of Rajasthan to the 'Eris' (tanks) of Tamil Nadu, traditional methods have helped communities manage water scarcity and survive drought conditions for centuries. Today, it is being revived as a critical solution to combat growing water stress, groundwater depletion, and the impacts of climate change.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify, // Justify for a cleaner look
            ),
            const SizedBox(height: 20),
            const Text(
              "🛠️ Common Techniques Explained",
              style: TextStyle(
                fontSize: 22, // Slightly larger
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "• **Rooftop Rainwater Harvesting:**\n"
              "This is the most common urban method. Rain falling on a building's roof (catchment) is channeled through gutters and pipes. This water is filtered and then stored in tanks for direct use (like gardening or washing) or, more importantly, directed into recharge pits or wells to replenish groundwater aquifers.\n\n"
              "• **Check Dams (Gully Plugs):\n**"
              "These are small, low barriers (made of stone, concrete, or earth) built across small streams or gullies. Their purpose isn't to create a large reservoir, but to **slow down** the flow of water, allowing it more time to percolate into the soil and recharge the local groundwater table. This also prevents soil erosion.\n\n"
              "• **Percolation Ponds & Tanks:**\n"
              "These are larger, excavated ponds or existing natural depressions that are designed to capture surface runoff from a large area. The bottom is left unlined, allowing the collected water to gradually seep into the ground, recharging aquifers over a wide area.\n\n"
              "• **Contour Bunding & Trenching:**\n"
              "A farming technique used on sloping land. Small earthen barriers (bunds) or trenches are built along the contours (lines of equal elevation) of the land. This breaks the velocity of water flowing downhill, preventing soil erosion and allowing the water to be absorbed by the soil for agricultural use.\n\n"
              "• **Traditional 'Tankas' / 'Kunds':**\n"
              "Found in the desert regions of Rajasthan, these are traditional underground tanks. They consist of a carefully prepared catchment area (called 'agoor') that slopes towards a central, sealed underground cistern, where water is stored, kept cool, and protected from evaporation for drinking purposes.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              "✅ Key Benefits of Water Harvesting",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "• **Recharges Groundwater:** It is the most effective way to counter the rapid depletion of groundwater levels caused by over-extraction from borewells.\n\n"
              "• **Reduces Soil Erosion:** By slowing runoff, techniques like check dams and contour bunding prevent the loss of valuable, fertile topsoil.\n\n"
              "• **Mitigates Flooding:** In urban areas, rooftop harvesting captures intense rainfall, reducing the load on storm-water drains and helping to prevent street flooding.\n\n"
              "• **Improves Water Quality:** Recharging groundwater through natural soil filtration often results in cleaner water compared to polluted surface water bodies.\n\n"
              "• **Reduces Dependence & Costs:** It lessens the reliance on expensive, centrally-supplied municipal water or tankers, promoting self-sufficiency for homes and communities.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Text(
              "🌟 Indian Success Stories",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.deepOrangeAccent,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "• **Alwar, Rajasthan:** Led by Rajendra Singh, the 'Waterman of India', community-led efforts built thousands of 'johads' (traditional check dams), reviving five dried-up rivers and transforming the ecology and economy of the region.\n\n"
              "• **Ralegan Siddhi, Maharashtra:** This village, once drought-prone and impoverished, was transformed by Anna Hazare through strict watershed management, contour bunding, and check dams, making it a water-surplus village.\n\n"
              "• **Tamil Nadu Mandate:** In 2001, Tamil Nadu became the first state to make rainwater harvesting compulsory for all buildings. This landmark policy led to a significant rise in groundwater levels in cities like Chennai.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
