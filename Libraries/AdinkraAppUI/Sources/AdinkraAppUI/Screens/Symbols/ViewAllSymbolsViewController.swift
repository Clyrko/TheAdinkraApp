import Foundation
import UIKit

private enum Constants {
    static let itemSize = CGSize(width: 151, height: 141)
    static let horizontalInset: CGFloat = 28
}

class ViewAllSymbolsViewController: BaseViewController {
    private let navBar = PopOverNavigationBar()
    private var searchBar = StyleSearchBar()
    private var backgroundView = SearchNotFoundView()
    private var titleLabel: StyleLabel!
    private var collectionView: UICollectionView!
    
    private var symbols: [SymbolPresentationModel] = [
        .init(id: 1, symbol: .named("symbol-aban"), title: "Aban", meaning: "A symbol of strength, seat of power, authority, and magnificence.", description: "Aban is the Akan word for “fortress” or “castle.”", pronunciation: "aban", categories: ["Strength", "Power"], isFavorite: false),
        .init(id: 2, symbol: .named("symbol-abe-dua"), title: "Abe Dua", meaning: "Abe Dua means palm tree.", description: "The palm tree is a symbol resourcefulnees because many diverse products emanate from that single tree: wine, oil, brooms, roofing material, etc.", pronunciation: "abe-dua", categories: ["Wealth", "Resourcefulness"], isFavorite: false),
        .init(id: 3, symbol: .named("symbol-adinkrahene"), title: "Adinkrahene", meaning: "Adinkrahene means King of the Adinkra symbols. It is a symbol for authority, leadership, and charisma.", description: "The etymology of Adinkrahene is Adinkra + ɔhene, literally “Adinkra king” or “king of the Adinkras.” This symbol is reportedly the inspiration of the design of the other symbols. The elegant figure with three concentric circles is easy to draw and its abstract form connotes the importance of ideas and concepts, which are the essence of Adinkra–they are visual representations of important concepts in Akan philosophy.", pronunciation: "adinkrahene", categories: ["Authority", "Leadership"], isFavorite: false),
        .init(id: 4, symbol: .named("symbol-adwo"), title: "Adwo", meaning: "Adwo means calmness. It is a symbol for peace, tranquility, and quiet.", description: "Keeping your inner peace and calmness, even if you face difficulties can alleviate the effects of chaos outside. Peace is of paramount importance, and you can achieve this by staying calm even in hard times.", pronunciation: "adwo", categories: ["Peace"], isFavorite: false),
        .init(id: 5, symbol: .named("symbol-agyindawuru"), title: "Agyindawuru", meaning: "Also known as Sunsum. Agyin’s gong. A symbol of faithfulness, alertness, and dutifulness", description: "Designed to commemorate the faithfulness of one Agyin who was a dutiful servant and gong-beater to the Asantehene.", pronunciation: "agyindawuru", categories: ["Faith"], isFavorite: false),
        .init(id: 6, symbol: .named("symbol-akoben"), title: "Akoben", meaning: "Akoben means “war horn.” It is a symbol of a call to action, readiness to be called to action, readiness, and voluntarism.", description: "The war horn was blown to assemble the nation for war. Everybody had to be alert to interpret the message that it was being used to convey so as to respond with the right action.", pronunciation: "akoben", categories: ["War"], isFavorite: false),
        .init(id: 7, symbol: .named("symbol-akofena"), title: "Akofena", meaning: "sword of war symbol of courage, valor, and heroism", description: "The crossed swords were a popular motif in the heraldic shields of many former Akan states. In addition to recognizing courage and valor, the swords can represent legitimate state authority.", pronunciation: "", categories: ["War"], isFavorite: false),
        .init(id: 8, symbol: .named("symbol-akoko-nan"), title: "Akoko Nan", meaning: "The foot of a hen. It is a symbol for nurturing coupled with discipline", description: "This Adinkra is from the proverb, “Akoko nan tia ba na enkum ba,” literally, “The foot of a hen steps on the child (chick) but it doesn’t kill the child (chick).”", pronunciation: "akoko-nan", categories: ["Discipline"], isFavorite: false),
        .init(id: 9, symbol: .named("symbol-akoma"), title: "Akoma", meaning: "Akoma means “heart,” and it is a symbol of love, goodwill, patience, faithfulness, fondness, endurance, and consistency.", description: "Though the heart shape is a universal symbol representing love, it is also an Adinkra symbol with a slighty different meaning. As an Adinkra, the heart shape represents patience and tolerance. In Akan, “Nya akoma,” literally “Get a heart” means take heart–be patient. Conversely, one who is impatient is said not to have a heart: “Onni akoma.”", pronunciation: "akoma", categories: ["Love"], isFavorite: false),
        .init(id: 10, symbol: .named("symbol-akoma-ntoaso"), title: "Akoma Ntoaso", meaning: "Akoma Ntoaso means “the joining of hearts.” It could also mean “united hearts.” It is a symbol of agreement, togetherness and unity or a charter; an amplification of the concept of Akoma.", description: "Metaphorically, akoma ntoso embodies understanding and agreement, as well as harmony within communities. The physical symbol depicts four hearts linked together, emphasizing mutual sympathy and immortality of the soul. Additionally, akoma ntoso promotes unity among families and communities. The importance of these concepts is demonstrated in the African Burial Ground, where different people from different cultures are brought together by shared affections, memories of lost ones, and African culture.", pronunciation: "akoma-ntoaso", categories: ["Love"], isFavorite: false),
        .init(id: 11, symbol: .named("symbol-ananse-ntentan"), title: "Ananse Ntentan", meaning: "Ananse Ntentan means “spider’s web.” The spider in Akan folklore–Ananse–is crafty and creative, and always outwitting his contemporaries by fair or foul means. Ananse Ntentan is a symbol of wisdom, craftiness, creativity, and the complexities of life.", description: "Ananse, the famous spider in Akan folktales is known for his cunning. However, in general, the spider is also respected for his creativity in weaving a web that is able to trap prey. The spider’s web is known for its strength. Indeed, a string of the web is known to be stronger and more versatile than steel of the same thickness.When Ananse features in folk tales, he usually comes along with Ntikuma, his son, Okonore Yaa, and some other family members. Known for the cheat he is, his associates are always wary of his antics lest they fall prey to his wit.", pronunciation: "ananse-ntentan", categories: ["Wisdom"], isFavorite: false),
        .init(id: 12, symbol: .named("symbol-ani-bere-a-enso-gya"), title: "Ani Bere A Enso Gya", meaning: "Ani Bere A Enso Gya is an Akan proverb which means “No matter how red-eyed one becomes (i.e. how serious one becomes), his eyes do not spark flames.” It is a symbol of patience, self-containment, self-discipline, and self-control.", description: "Ani bere a, nso gya, anka mani abere koo; Seriousness does not show fiery eyes, else you would see my face all red.", pronunciation: "", categories: ["Self"], isFavorite: false),
        .init(id: 13, symbol: .named("symbol-asase-ye-duru"), title: "Asase Ye Duru", meaning: "Asase Ye Duru means “the earth has weight.” It is a symbol of providence and the divinity of Mother Earth.", description: "Tumi nyina ne asase; All power emanates from the earth.", pronunciation: "asase-ye-duru", categories: ["Nature", "Wealth"], isFavorite: false),
        .init(id: 14, symbol: .named("symbol-aya"), title: "Aya", meaning: "Aya means “fern.” It is a symbol of endurance, independence, defiance against difficulties, hardiness, perseverance, and resourcefulness.", description: "This symbol signifies endurance as well as resourcefulness. This is because ferns are hardy plants that can grow in highly unusual places. They need little water to thrive and can withstand the toughest climates. Due to this, the symbol is also associated with durability.Aya can also mean ‘I’m not afraid of you’ or ‘I’m independent of you’, representing strength, defiance against oppression, and independence. Many people choose to wear Aya tattoos, claiming that they can feel their power and inner strength. A person who wears the Aya symbol suggests that he has endured many difficulties in life and face various obstacles which he has overcome. ", pronunciation: "aya", categories: ["Power", "Strength"], isFavorite: false),
        .init(id: 15, symbol: .named("symbol-bese-saka"), title: "Bese Saka", meaning: "Bese Saka is a bunch of cola nuts. It is a symbol of affluence, power, abundance, plenty, togetherness, and unity.", description: "Cola nuts were a prized cash crop in West Africa and so they are closely associated with economic success", pronunciation: "bese-saka", categories: ["Power"], isFavorite: false),
        .init(id: 16, symbol: .named("symbol-bi-nka-bi"), title: "Bi Nka Bi", meaning: "Bi Nka Bi means “Nobody should bite another.” It is a symbol of justice, fairplay, freedom, peace, forgiveness, unity, harmony, and the avoidance of conflict or strife.", description: "This symbol cautions against provocation and strife. The image is based on two fish biting each other tails", pronunciation: "bi-nka-bi", categories: ["Peace"], isFavorite: false),
        .init(id: 17, symbol: .named("symbol-dame-dame"), title: "Dame Dame", meaning: "Dame-Dame means “chequered.” It is a symbol of intelligence, ingenuity, and strategy.", description: " It was inspired by a popular Ghanaian board game known as 'Dame Dame'.", pronunciation: "dame-dame", categories: ["Self", "Wisdom"], isFavorite: false),
        .init(id: 18, symbol: .named("symbol-denkyem"), title: "Denkyem", meaning: "Denkyem means “crocodile.” It is a symbol of adaptability, cleverness, from the proverb, “Ɔdɛnkyɛm da nsuo mu nanso ɔhome mframa,” to wit, “The crocodile lives in water yet it breathes air.”", description: "One may attribute the adaptability of the reptile to himself to show his own adaptability and ingenuity coupled with formidability and mystery. The idea that it takes ingenuity to live in water but breathe air comes from the inability of humans to do that. Hence, the anthropomorphized crocodile becomes a symbol that embodies superhuman traits the user desires to communicate about himself.", pronunciation: "denkyem", categories: ["Wisdom"], isFavorite: false),
        .init(id: 19, symbol: .named("symbol-dono-ntoaso"), title: "Dono Ntoaso", meaning: "Dono Ntoaso means “extension of dono” or “the double dono”–two tension talking drums joined together. It is a symbol of united action, alertness, goodwill, praise, rejoicing, and adroitness.", description: "It also signifies strength and unity", pronunciation: "", categories: ["Self", "Home", "Strength"], isFavorite: false),
        .init(id: 20, symbol: .named("symbol-dono"), title: "Dono", meaning: "Dono is a type of tension talking drum. It is a symbol of appelation, praise, goodwill and rhythm.", description: "Dono is a type of tension talking drum with strings connecting both ends which are covered with animal skins. It is usually held under the armpit and produces a different sound based on how tightly it is gripped under the arm. It is a symbol of appelation, praise, goodwill and rhythm.", pronunciation: "", categories: ["Self", "Home", "Strength"], isFavorite: false),
        .init(id: 21, symbol: .named("symbol-duafe"), title: "Duafe", meaning: "Duafe means “wooden comb.” It i a symbol of feminine consideration or good feminine qualities such as patience, prudence, fondness, love, and care.", description: "Significance Duafe is a combination of dua (English: wood, wooden) and afe (English: comb). The duafe was an important item in the collection of items women used for grooming.", pronunciation: "duafe", categories: ["Self", "Home", "Nature"], isFavorite: false),
        .init(id: 22, symbol: .named("symbol-dwennimmen"), title: "Dwennimmen", meaning: "Dweninmmen means “the horns of a ram.” It represents strength (in mind, body, and soul), humility, wisdom, and learning.", description: "Humility is a cherished virtue among the Akans. Modesty in dress and lifestyle is upheld and there are perpetual reminders of the finitude of life. For instance, the adinkra symbol Owuo Atwedee is one of such reminders. The saying goes that everybody will climb the ladder of death. It is a warning that strong and powerful though one may be, death is inevitable. We have overcome death and all our attempts at inventing potions that will conquer it have failed. There is at least one force—call it nature, call it God, cal it whatever—that operates in the affairs of men and that prevails in the end. To be humble is to order one’s life and arrange one’s affairs with this in mind.", pronunciation: "dwennimmen", categories: ["Strength", "Wisdom"], isFavorite: false),
        .init(id: 23, symbol: .named("symbol-eban"), title: "Eban", meaning: "Eban means “fence.” It is a symbol of safety, security, and love.", description: "The home of the Akan is a special place. A home which has a fence around it is considered to be an ideal residence", pronunciation: "eban", categories: ["Love", "Home"], isFavorite: false),
        .init(id: 24, symbol: .named("symbol-epa"), title: "Epa", meaning: "Epa means “handcuffs.” It is a symbol of law and justice.", description: "A symbol of the uncompromising nature of the law to offenders and discourage slavery.", pronunciation: "epa", categories: ["Self", "Home", "War"], isFavorite: false),
        .init(id: 25, symbol: .named("symbol-ese-ne-tekrema"), title: "Ese Ne Tekrema", meaning: "Ese ne Tekrema means “teeth and tongue.” It is a symbol of improvement, advancement, growth, the need for friendliness and interdependence.", description: "The Akan people say that « the teeth and the tongue play interdependent roles in the mouth", pronunciation: "ese-ne-tekrema", categories: ["Self", "Home"], isFavorite: false),
        .init(id: 26, symbol: .named("symbol-fanfanto"), title: "Fanfanto", meaning: "Fafanto means “butterfly.” It is a symbol of tenderness, gentleness, honesty, and fragility.", description: "The butterfly is a tender and gentle creature fluttering around with its beautiful wings.The symbol embodies the essence of the butterfly; fragility, gentleness and tenderness. It can also be likened to the freedom the butterflies enjoy, flying around without a care in the world.", pronunciation: "", categories: ["Love", "Peace"], isFavorite: false),
        .init(id: 27, symbol: .named("symbol-fihankra"), title: "Fihankra", meaning: "Fihankra is an enclosed or secured compound house. It is a symbol of brotherhood, safety, security, completeness, and solicarity.", description: "Communal living among the Akans is the default. “It takes a village to raise a child” is not just figuratively true but literally lived. The underlying concept is that of the common humanity of all mankind. In the olden days, the severest punishment for an offending member of society was banishment. The expression is “twa n’asu” to wit, “Cast him across the river.” To do that is to ostracize the person, publicly repudiating his action to deter others.", pronunciation: "fihankra", categories: ["Home"], isFavorite: false),
        .init(id: 28, symbol: .named("symbol-fofo"), title: "Fofo", meaning: "Fofo is the name of a flowering plant (bidens pilosa). It is a symbol of warning against jealousy and covetousness.", description: "This plant has yellow flowers which turn into black spiky-like seeds when its petals drop.", pronunciation: "", categories: ["Nature"], isFavorite: false),
        .init(id: 29, symbol: .named("symbol-funtumfunefu-denkyemfunefu"), title: "Funtumfunefu Denkyemfunefu", meaning: "Funtumfunefu Denkyemfunefu represents two mythical crocodiles (or one, depending on how one looks at it) with one shared stomach. It is a symbol of unity in diversity giving a common destiny; sharing.", description: "The proverb from which the symbol is derived is “Funtumfunafu Denkyemfunafu, wowo yafunu koro nanso wonya biribi a wofom efiri se aduane no de no yete no wo menetwitwie mu,” to wit, Funtumfunafu and denkyemfunafu share a stomach but when they get something (food) they strive over it because the sweetness of the food is felt as it passes through the throat.", pronunciation: "funtumfunefu-denkyemfunefu", categories: ["Peace", "Self"], isFavorite: false),
        .init(id: 30, symbol: .named("symbol-gyawu-atiko"), title: "Gyawu Atiko", meaning: "Kwatakye Atiko means “the back of Kwatakye’s head.” It is a symbol of valor and bravery.", description: "This symbol is also called Gyawu Atiko. It is said to be a hairstyle of Kwatakye, a war captain of old Asante.", pronunciation: "", categories: ["War"], isFavorite: false),
        .init(id: 31, symbol: .named("symbol-gye-nyame"), title: "Gye Nyame", meaning: "Gye Nyame means “Except God.” It expresses the omnipotence and supremacy of God in all affairs.", description: "Gye Nyame is arguably the most popular Adinkra symbol. It expresses the deep faith the Akans have in the Supreme Being, called by many names and titles including Onyame (Nyame), Onyankopɔn, Twereduampɔn (the reliable one), and many others.In the Akan scheme of things, God (Nyame) is omnipotent, omnipresent and omniscient.Gye Nyame has become an icon of all Adinkra, encapsulating the faith of an African people who see God’s involvement in every aspect of human life.", pronunciation: "gye-nyame", categories: ["Love", "Power", "Peace"], isFavorite: false),
        .init(id: 32, symbol: .named("symbol-hwehwemudua"), title: "Hwehwemudua", meaning: "Hwehwemudua means “rod of investigation,” that is, a measuring rod. It is a symbol of excellence, superior quality, perfection, knowledge, and critical examination.", description: "It represents high quality and excellence in one's endeavours.", pronunciation: "hwehwemudua", categories: ["Wisdom"], isFavorite: false),
        .init(id: 33, symbol: .named("symbol-hye-wo-nhye"), title: "Hye Wo Nhye", meaning: "Hye Wo Nhye literally means “Burn you won’t burn.” It is a figurative expression for something which is unburnable. It is a symbol of toughness and imperishability. It is also a symbol of permanence.", description: "The meaning of this symbol was derived from the practices of walking on fiery coals by traditional African priests, without burning their feet. The act of walking over the hot coals without harm is a complete contradiction to human logic, and indicates the priests’ nature of holiness and physical and mental endurance that allowed this inconceivable act to become possible. Hye Won Hye serves as an inspiration to others to be tough in difficult times and endure hardships that may come your way.", pronunciation: "", categories: ["Strength"], isFavorite: false),
        .init(id: 34, symbol: .named("symbol-kramo-bone-amma-yeanhu-kramo"), title: "Hwehwemudua", meaning: "Kramo Bone Amma Yeanhu Kramo Pa means “the bad muslim makes it difficult for a good one to be recognized.” It is a symbol of warning against deception and hypocrisy. This symbol is also called “Papani amma yeanhu kramo,” which means the abundance of good men made it difficult to identify muslims.", description: "Solomon’s knot (a Celtic knot) is just about the same as “Kramo Bone…” According to Ancient Symbols, Solomon’s knot can be found in most major civilizations albeit with different meanings. They also say that because the links in the knot have no beginning nor end they should represent eternity or immortality; and because they are intertwined they should represent love. This is a sharp deviation from the Akan interpretation of the symbol which emphasizes a comparison of the two links. Whichever interpretation of the symbol in the Akan you choose—whether papani… or kramo bɔne…, the emphasis in Akan is the similarity or contrast between the two links.", pronunciation: "", categories: ["Wisdom"], isFavorite: false),
        .init(id: 35, symbol: .named("symbol-kuronti-ne-akwamu"), title: "Kuronti Ne Akwamu", meaning: "Kuronti and Akwamu are two groups that together form the council of a town or village. Hence, the symbol represents democracy, sharing ideas, and taking council.", description: "Being two distinct groups, they may each have their own individual interests but it is out of this tension that an acceptable consensus is forged to govern the whole.", pronunciation: "kuronti-ne-akwamu", categories: ["Power"], isFavorite: false),
        .init(id: 36, symbol: .named("symbol-mako"), title: "Mako", meaning: "Mako means “peppers.” It is a symbol of inequality and uneven development.", description: "Mako is a shortened form of the Akan proverb “Mako nyinaa mpatu mmere,” literally “All peppers (presumably on the same branch) do not ripen simultaneously.”This proverb admonishes the greater ones to help the less fortunate with the implicit understanding that fortunes could reverse so that they would also need someone’s help. As the Akans say, “Mmerɛ dane,” literally, “Time changes” so any advantage one may have now may not persist forever.“Mako nyinaa mpatu mmere” could also be an exhortation to those behind to strive for advancement and not resign to fate. That someone has attained greatness shows that it is attainable. Yes, some may shoot ahead first but eventually others can catch up—eventually all the peppers will ripen.", pronunciation: "mako", categories: ["Self"], isFavorite: false),
        .init(id: 37, symbol: .named("symbol-menso-wo-kenten"), title: "Menso Wo Kenten", meaning: "Menso Wo Kenten literally means “I am not carrying your basket.” It is a symbol of industry, self-reliance, and economic self-determination.", description: "The Adinkra symbol Menso Wo Kenten represents women’s financial independence. It literally means “I won’t carry your basket but my own” and is the symbol of entrepreneurship.", pronunciation: "menso-wo-kenten", categories: ["Self"], isFavorite: false),
        .init(id: 38, symbol: .named("symbol-mframadan"), title: "Mframadan", meaning: "Mframadan means “well-ventilated house.” A symbol of resilience and readiness to face the vicissitudes of life", description: "The Akan house is not only well ventilated, it is resilient and can withstand the hazards of storms, rainfall and the tropical hot weather.", pronunciation: "mframadan", categories: ["Self", "Home"], isFavorite: false),
        .init(id: 39, symbol: .named("symbol-mmere-dane"), title: "Mmere Dane", meaning: "Mmere Dane means “time changes” or “times change.” It is a symbol for the temporariness of good times.", description: "Good situations are not permanent so the fortunate should not boast; bad situations are not permanent so the less fortunate should not give up. No condition is permanent, hence, man should be humble, cooperative and hopeful in all his endeavours.", pronunciation: "mmere-dane", categories: ["Peace", "Home"], isFavorite: false),
        .init(id: 40, symbol: .named("symbol-mpatapo"), title: "Mpatapo", meaning: "Mpatapo means “pacification knot.” It is a symbol of pacification, forgiveness, and reconciliation.", description: "Mpatapo represents the bond or knot that binds the separate parties in a dispute to a peaceful, harmonious reconciliation. It is a symbol of peacemaking after strife.", pronunciation: "mpatapo", categories: ["Peace"], isFavorite: false),
        .init(id: 41, symbol: .named("symbol-mpuannum"), title: "Mpuannum", meaning: "Mpuannum means “five tufts” (of hair). It is a symbol of loyalty and priestly office.", description: "This symbol is said to be the hairstyle of joy. It is the traditional hairstyle of the priestesses. ... The design of the adinkra symbol mpuannum resembles the way the priestesses' hair was tied. ...It also represents the devotion and faithfulness one displays when doing a task required of one. In addition, mpuannum means loyalty or the embodiment of lofty duty to a desired goal.", pronunciation: "mpuannum", categories: ["Love", "Faith"], isFavorite: false),
        .init(id: 42, symbol: .named("symbol-nea-onnim"), title: "Nea Onnim", meaning: "Nea Onnim means “He who does not know.”", description: "It is from the Akan proverb, “Nea onnim no sua a ohu,” which translates as, “When he who does not know learns, he gets to know.”", pronunciation: "nea-onnim", categories: ["Wisdom", "Self"], isFavorite: false),
        .init(id: 43, symbol: .named("symbol-nkonsonkonson"), title: "Nkonsonkonson", meaning: "Nkonsonkonson means “chain.” It is a symbol of unity and community.", description: "A reminder to contribute to the community, that in unity lies strength", pronunciation: "nkonsonkonson", categories: ["Home", "Peace", "Love"], isFavorite: false),
        .init(id: 44, symbol: .named("symbol-nkyinkyim"), title: "Nkyinkyim", meaning: "Nkyinkyim means “twisting.” It is a symbol representing the tortuous nature of life’s journey.", description: "The design of Nkyinkyim depicts the tortuous nature of life’s journey. hese twists and turns require one to be versatile and resilient to survive.The proverb associated with this symbol is “Ɔbra kwan yɛ nkyinkyimii,” which literally means “Life’s journey is twisted.”Since a great number of proverbs are to the young and inexperienced, it is proper to construe this symbol as admonishing younger persons to brace up for what life may throw at them. Yes, they may not be aware of impending challenges but that is no excuse to resign to fate. By sheer force of will and determination, they can succeed.", pronunciation: "nkyinkyim", categories: ["Home", "Self"], isFavorite: false),
        .init(id: 45, symbol: .named("symbol-nsaa"), title: "Nsaa", meaning: "Nsaa is a type of woven cloth. It is a symbol of excellence, genuineness, authenticity; from the Akan proverb “Nea onnim nsaa na oto n’ago,” to wit, he who does not know quality nsaa will buy the fakes.", description: "Craftsmanship is an indispensable quality in the weaving of cloth. Whether Kente or some other fabric, the traditional methods of weaving involve a laborious process of joining yarns together thread by thread to form thin strips which are then sewn together. Modern technology has afforded us the opportunity to be able to generate similitudes of authentic woven cloths at scale but their value cannot surpass that of the woven cloth. The infusion of human effort in the creation of the fabric amplifies its value. It shows an appreciation for craftsmanship, effort, authenticity, and thoughtfulness in the creation of the cloth. It confirms the tacit contract between the creator and the customer—an implied understanding that they share common tastes and values.", pronunciation: "nsaa", categories: ["Self"], isFavorite: false),
        .init(id: 46, symbol: .named("symbol-nsoromma"), title: "Nsoromma", meaning: "Nsoromma is the Akan word for “star.” It literally translates to “child of the heavens.” It is a symbol of faith and the belief in patronage and dependency on a supreme being", description: "A reminder that God is the father and watches over all people.", pronunciation: "nsoromma", categories: ["Faith"], isFavorite: false),
        .init(id: 47, symbol: .named("symbol-nteasee"), title: "Nteasee", meaning: "Nteasee is the Akan word for “understanding.” It is a symbol of understanding and cooperation.", description: "It urges the people to be more considerate and compassionate towards one another. Peace and harmony will reign when people overlook their differences and work together.", pronunciation: "", categories: ["Peace"], isFavorite: false),
        .init(id: 48, symbol: .named("symbol-nyame-biribi-wo-soro"), title: "Nyame Biribi Wo Soro", meaning: "God, there is something in the heavens. A symbol of hope and inspiration", description: "God lives in the heavens and, since he owns goodies, that is where they are to be found. This Adrinkra is a prayer to God to grant a wish. The Akans believe that God is in the heavens to hear prayers, bless his people, and watch over them. They also believe that he is there to ensure that his purposes are fulfilled on earth.", pronunciation: "nyame-biribi-wo-soro", categories: ["Faith"], isFavorite: false),
        .init(id: 49, symbol: .named("symbol-nyame-dua"), title: "Nyame Dua", meaning: "God’s tree (sacred stump). A symbol of God’s presence and protection", description: "The symbol urges people to acknowledge the presence and protection of God, and also worship and venerate Him insincerity.", pronunciation: "", categories: ["Faith", "Nature"], isFavorite: false),
        .init(id: 50, symbol: .named("symbol-nyame-nwu-na-mawu"), title: "Nyame Nwu Na Mawu", meaning: "Nyame Nwu Na Mawu means “God won’t die for me to die.” It is a symbol expressing the immortality of the human soul, expressing faith in God to preserve one’s soul.", description: "Nyame Nwu Na Mawu is a bold declaration of faith by the declarant that his life is hidden in God and therefore the one who wants to take it must first take God’s life before he can get to him. Just as Paul describes in one of his epistles that the life of the Christian as hidden in Christ with God, … The quest for immortality has been abiding meditation for generations of thinkers but this confession overlays it with a dimension of faith. God cannot die therefore I cannot die. The reason he cannot die primarily does not rest in his ability to keep himself but in God’s power and insurmountable authority which he exerts over the creation.", pronunciation: "", categories: ["Faith"], isFavorite: false),
        .init(id: 51, symbol: .named("symbol-odo-nnyew-fie-kwan"), title: "Odo Nnyew Fie Kwan", meaning: "Odo Nnyew Fie Kwan means “Love does not lose its way home.Those led by love always end up in the right place.", description: "The symbol exhibits bilateral symmetry with each half spotting two spirals. Just as the spirals in the alternative Sankofa symbol signified a return, the spirals here probably also do the same. Love, in its various shades and colors is a central theme in all relationships. Without it, relationships can hardly survive, not to talk of thriving. Being a polygamous society, the Akans recognize and celebrate erotic love between men and women.", pronunciation: "odo-nnyew-fie-kwan", categories: ["Love"], isFavorite: false),
        .init(id: 52, symbol: .named("symbol-okuafo-pa"), title: "Okuafo Pa", meaning: "Okuafo Pa means “good farmer.” It is a symbol of diligence, hard work, and entrepreneurship", description: "Okuafoo pa ne obi a oye nsiyefoo, ono na ose : w'afuo so a, woye ne nyinaa; The good and industrious farmer says: No matter how big your farm is you tend it all.", pronunciation: "okuafo-pa", categories: ["Home", "Self"], isFavorite: false),
        .init(id: 53, symbol: .named("symbol-osram-ne-nsoromma"), title: "Osram Ne Nsoromma", meaning: "Osram ne Nsoromma means “moon and star.” It is a symbol of faithfulness, fondness, harmony, benevolence, love, loyalty, and femininity, from the proverb, “Kyekye pe awaree,” meaning “The North Star loves marriage.” She is always in the sky waiting for the return of the moon, her husband. ", description: "This symbol reflects the harmony that exists in the bonding between a man and a woman.Proverb: Kyekye pe aware. (The North Star has a deep llove for marriage. She is always in the sky waiting for the return of the moon, her husband.)", pronunciation: "osram-ne-nsoromma", categories: ["Love", "Faith"], isFavorite: false),
        .init(id: 54, symbol: .named("symbol-owuo-atwedee"), title: "Owuo Atwedee", meaning: "Owuo Atwedee means “ladder of death.” This symbol gets its name from the proverb, “Owuo atwedee baakofoo mforo,” meaning, “Death’s ladder is not climbed by just one person.” It is a symbol of the certainty and universality of death", description: "Owuo Atwedee gets its name from the Akan proverb, “Owuo atwedeɛ baakofoɔ mforo” which literally means “Death’s ladder: not one person climbs it.” Alternatively,: death’s ladder is not climbed by just one person. The proverb expresses the belief that death is universal to all men: everybody will die. The implications of this belief could be varied though. For example, to warn a particularly proud or cruel person of his mortality this proverb may be used. It may also be used to console bereaved persons that death is not such an extraordinary event but one that lies ahead for all.", pronunciation: "owuo-atwedee", categories: ["Home", "Love"], isFavorite: false),
        .init(id: 55, symbol: .named("symbol-sankofa"), title: "Sankofa", meaning: "Sankofa means “Go back and get it.” As the Akan proverb goes, “Se wo were fi na wosan kofa a yenkyiri.” To wit, it is not taboo to go back and get something after you have forgotten it. More literally, it means if you forget and you go back to get it, there is nothing wrong with it.", description: "There are two Sankofa symbols. The more popular one is the bird with the contorted neck but the other one which looks more like the conventional symbol for the heart is also used. This figure is symmetrical about a vertical axis with each half spotting two spirals. One at the top and the other at the bottom. The spirals probably represent the idea of going around but ending up at a point–presumably the source. We should not forget our roots for its tendency is to feature inexorably in every aspect of our lives.", pronunciation: "sankofa", categories: ["Wisdom", "Self"], isFavorite: false),
        .init(id: 56, symbol: .named("symbol-sepow"), title: "Sepow", meaning: "Sepow is the executioner’s knife. It is a symbol of justice.", description: "The Akans believed that before being executed, the victim could curse the king for ordering the execution. Due to this, the executioner would thrust the knife into the victim’s cheek and tear the mouth open before he could place the curse.", pronunciation: "sepow", categories: ["Wisdom"], isFavorite: false),
        .init(id: 57, symbol: .named("symbol-tamfo-bebre"), title: "Tamfo Bebre", meaning: "Tamfo Bebre means “The enemy will suffer” or “The enemy will stew in his own juice.” It is a symbol for ill-will, jealousy, and envy.", description: "“Ɔtanfo Bɛbrɛ” literally means “An (unnamed) enemy will suffer” while “Me tanfo bɛbrɛ” means “My enemy will suffer.”“Tamfo” is a misspelling of “Tanfo,” the Akan word for “enemy.” Tamfo Bɛbrɛ conjures up the image of a calabash or bowl that is difficult to submerge because the harder one pushes, the stronger the restistance one feels. Some Akans use such imagery to describe what futility and struggle their enemies must endure to keep them down.", pronunciation: "tamfo-bebre", categories: ["Self"], isFavorite: false),
        .init(id: 58, symbol: .named("symbol-uac-nkanea"), title: "UAC Nkanea", meaning: "UAC Nkanea means “UAC lights.” It is a symbol of technological advancement.", description: "Several of the symbols in the adinkra cloths record social changes that have been brought about by both external and internal factors. For example, the aban (castle, fortress), kurontire ne akwamu (council of state), ohene tuo (king’s gun), UAC nkanea (UAC lights), benz, television, kookoo dua (cocoa tree), and sedee or serewa (cowrie shell) symbols record specific technological developments and historical events that led to particular changes and factors that influenced the direction of such changes in the Asante (Akan) and Ghanaian society.", pronunciation: "uac-nkanea", categories: ["Self"], isFavorite: false),
        .init(id: 59, symbol: .named("symbol-wawa-aba"), title: "Wawa Aba", meaning: "Wawa Aba means “seed of the wawa (tree).” It is a symbol of hardiness, toughness, and perseverance.", description: "Wawa Aba literally means “seed of the wawa,” that is, seed of the wawa plant (Triplochiton scleroxylon). This seed is reputed for its hardness. Thus, Wawa Aba is a symbol of hardness, strength, toughness, endurance, durability, and so on. The wood of the wawa plant is popular in the region for its use in building and carpentry.", pronunciation: "wawa-aba", categories: ["Nature"], isFavorite: false),
        .init(id: 60, symbol: .named("symbol-woforo-dua-pa-a"), title: "Woforo Dua Pa A", meaning: "Woforo Dua Pa A means “when you climb a good tree.” It is from the Akan proverb “Woforo dua pa a na yepia wo,” meaning “It is when you climb a good tree that we give you a push.” It is a symbol of support for good causes.", description: "More metaphorically, it means that when you work for a good cause, you will get support. ", pronunciation: "woforo-dua-pa-a", categories: ["Nature"], isFavorite: false)
    ]

    private var dataSource: [SymbolPresentationModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .styleWhite
        dataSource = symbols
        initializeView()
        layoutConstraint()
    }
    
    private func filterSymbols(text: String){
        defer { collectionView.reloadData() }
        guard text.isNotEmpty else {
            dataSource = symbols
            return
        }
        dataSource = symbols.filter{ $0.title.localizedCaseInsensitiveContains(text)
        }
    }
    
    private func showProfileScreen() {
        let controller = applicationDIProvider.makeProfileViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - COLLECTIONVIEW
extension ViewAllSymbolsViewController: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if dataSource.isEmpty {
            backgroundView.frame = collectionView.frame
            collectionView.backgroundView = backgroundView
        }else{
            collectionView.backgroundView = nil
        }
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SymbolCell.Identifier, for: indexPath) as? SymbolCell else { fatalError() }
        cell.setup(with: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Constants.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = SymbolDetailsViewController()
        controller.symbols = dataSource[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        26
//    }
//
//    func indexTitles(for collectionView: UICollectionView) -> [String]? {
//    }
//
//    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
//    }
}


//MARK: - LAYOUT
extension ViewAllSymbolsViewController {
    private func initializeView() {
        navBar.onBackAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        navBar.onProfileAction = { [weak self] in
            self?.showProfileScreen()
        }
        navBar.title = "View All Symbols"
        
        titleLabel = .init(
            with: .header2,
            textColor: .styleBlack,
            textAlignment: .left,
            text: "All Symbols"
        )
        
        searchBar.onTextChanged = { [weak self] text in
            self?.filterSymbols(text: text)
        }
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = 30
        collectionViewFlowLayout.minimumInteritemSpacing = 20
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.backgroundView = SearchNotFoundView()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SymbolCell.self, forCellWithReuseIdentifier: SymbolCell.Identifier)
        
        view.addSubview(navBar)
        view.addSubview(searchBar)
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func layoutConstraint() {
        navBar.layout {
            $0.top == view.topAnchor
            $0.leading == view.leadingAnchor
            $0.trailing == view.trailingAnchor
        }
        
        searchBar.layout {
            $0.top == navBar.bottomAnchor + 36
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        titleLabel.layout {
            $0.top == searchBar.bottomAnchor + 40
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
        }
        
        collectionView.layout {
            $0.top == titleLabel.bottomAnchor + 24
            $0.leading == view.leadingAnchor + Constants.horizontalInset
            $0.trailing == view.trailingAnchor - Constants.horizontalInset
            $0.bottom == view.bottomAnchor
        }
    }
}
