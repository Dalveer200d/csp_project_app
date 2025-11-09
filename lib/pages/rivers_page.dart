import 'package:flutter/material.dart';

class RiversPage extends StatelessWidget {
  const RiversPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rivers of India"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white, // Added for better contrast
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "https://i.pinimg.com/1200x/9b/b6/fe/9bb6fe0465f4eb63efa6129547015b12.jpg",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
                // Added loading and error builders for a better user experience
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
              "The Lifelines of India 🇮🇳",
              style: TextStyle(
                fontSize: 24, // Slightly larger
                fontWeight: FontWeight.bold,
                color: Color(0xFF191970), // Midnight Blue
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "India is a land of rivers, often revered as goddesses and cradles of civilization. From the mighty, snow-fed Himalayan rivers like the Ganga and Brahmaputra to the serene, rain-fed peninsular rivers like the Godavari and Narmada, these water bodies play a crucial and multifaceted role in India’s economy, culture, and ecology. They support agriculture through vast irrigation networks, provide drinking water to millions, enable transportation, and sustain rich, diverse aquatic ecosystems. The very fabric of Indian life is woven around these lifelines.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify, // Added for cleaner text blocks
            ),
            const SizedBox(height: 20),

            // --- Major River Systems (Expanded) ---
            const Text(
              "🌊 Major River Systems",
              style: TextStyle(
                fontSize: 22, // Slightly larger
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "1️⃣ **The Ganga River System:**\n"
              "Originating from the Gangotri Glacier in the Himalayas as the Bhagirathi, the Ganga flows over 2,500 km through Uttarakhand, Uttar Pradesh, Bihar, and West Bengal before emptying into the Bay of Bengal. It is the most sacred river for Hindus, with major pilgrimage cities like Varanasi, Haridwar, and Prayagraj on its banks. Its vast basin is one of the most fertile and densely populated regions on Earth, supported by major tributaries like the **Yamuna**, **Ghaghara**, and **Son**.\n\n"
              "2️⃣ **The Brahmaputra River System:**\n"
              "Originating as the Yarlung Tsangpo in Tibet, this mighty trans-boundary river enters India in Arunachal Pradesh. It flows westward through Assam, creating a wide, braided valley known for its fertile plains and the world's largest river island, **Majuli**. The Brahmaputra is known for its immense volume and seasonal flooding. It merges with the Ganga (or Padma) in Bangladesh to form the world's largest delta, the Sundarbans.\n\n"
              "3️⃣ **The Godavari River System:**\n"
              "Often called the **'Dakshina Ganga'** (Ganga of the South), the Godavari is the longest river in Peninsular India (approx. 1,465 km). It rises from Trimbakeshwar in the Western Ghats near Nashik, Maharashtra, and flows southeast across the Deccan Plateau, providing vital irrigation to Maharashtra, Telangana, and Andhra Pradesh before flowing into the Bay of Bengal.\n\n"
              "4️⃣ **The Krishna River System:**\n"
              "The second-largest east-flowing peninsular river, the Krishna, also originates in the Western Ghats at Mahabaleshwar. It flows through Karnataka, Telangana, and Andhra Pradesh. Its basin is known for its rich agricultural land, supported by major tributaries like the **Tungabhadra** and **Bhima**, and significant dams like the Nagarjuna Sagar.\n\n"
              "5️⃣ **The Narmada and Tapti Rivers:**\n"
              "These are unique as they are the two longest rivers in India that flow **westward** into the Arabian Sea. The Narmada originates from the Amarkantak Plateau and flows through a **rift valley** between the Vindhya and Satpura ranges, creating scenic landscapes like the Dhuandhar Falls. The Tapti (or Tapi) flows parallel to the Narmada, also through a rift valley, and empties into the Gulf of Khambhat.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // --- New Section: Cultural Significance ---
            const Text(
              "🙏 Cultural & Spiritual Significance",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "In India, rivers are more than just water; they are deities. The Ganga is personified as 'Ganga Ma' (Mother Ganga), a goddess who grants salvation. Riverbanks, or 'ghats', are centers of life and death, and major festivals like the **Kumbh Mela**, the largest peaceful human gathering on Earth, take place at the confluence of sacred rivers. This deep spiritual connection underscores the public's profound relationship with these water bodies.",
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // --- Environmental Section (Expanded) ---
            const Text(
              "♻️ Importance and Modern Challenges",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Ecologically, rivers recharge groundwater, support critical biodiversity (like the endangered **Gangetic Dolphin**), and are vital for hydroelectric power generation. However, these lifelines are under severe threat.\n\n"
              "**Major challenges include:**\n"
              "• **Pollution:** The dumping of untreated sewage from cities and industrial effluents poses the greatest threat.\n"
              "• **Over-extraction:** Water is heavily diverted for agriculture and urban use, reducing the rivers' natural flow.\n"
              "• **Physical Encroachment:** Illegal sand mining and construction on floodplains damage river ecology.\n"
              "• **Climate Change:** Melting glaciers in the Himalayas threaten the long-term flow of perennial rivers like the Ganga.\n\n"
              "Protecting river health through initiatives like the 'Namami Gange' programme is not just an environmental goal but a national necessity for sustainable living.",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
