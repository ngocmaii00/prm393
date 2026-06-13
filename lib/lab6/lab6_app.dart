import 'package:flutter/material.dart';

class Lab6App extends StatelessWidget {
  const Lab6App({super.key});

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF2F6F5E);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 6 - Responsive Movies',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
        scaffoldBackgroundColor: const Color(0xFFF6F7F9),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
      ),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  static const List<String> _genres = [
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
    'Adventure',
    'Animation',
    'Thriller',
    'Fantasy',
  ];

  static const List<String> _sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  String _searchQuery = '';
  late final TextEditingController _searchController;
  String _selectedSort = 'A-Z';
  final Set<String> _selectedGenres = {};

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Movie> get _visibleMovies {
    final query = _searchQuery.trim().toLowerCase();
    final movies = allMovies.where((movie) {
      final matchesSearch =
          query.isEmpty || movie.title.toLowerCase().contains(query);
      final matchesGenre =
          _selectedGenres.isEmpty || movie.genres.any(_selectedGenres.contains);

      return matchesSearch && matchesGenre;
    }).toList();

    switch (_selectedSort) {
      case 'Z-A':
        movies.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        movies.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        movies.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'A-Z':
      default:
        movies.sort((a, b) => a.title.compareTo(b.title));
        break;
    }

    return movies;
  }

  void _toggleGenre(String genre) {
    setState(() {
      if (_selectedGenres.contains(genre)) {
        _selectedGenres.remove(genre);
      } else {
        _selectedGenres.add(genre);
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
      _selectedGenres.clear();
      _selectedSort = 'A-Z';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isWideScreen = screenWidth >= 800;
    final horizontalPadding = screenWidth >= 1000 ? 32.0 : 16.0;
    final visibleMovies = _visibleMovies;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                18,
                horizontalPadding,
                14,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeadingSection(
                    visibleCount: visibleMovies.length,
                    selectedGenreCount: _selectedGenres.length,
                    isWideScreen: isWideScreen,
                  ),
                  const SizedBox(height: 18),
                  _FilterSection(
                    genres: _genres,
                    searchController: _searchController,
                    sortOptions: _sortOptions,
                    selectedGenres: _selectedGenres,
                    selectedSort: _selectedSort,
                    onSearchChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    onGenrePressed: _toggleGenre,
                    onSortChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _selectedSort = value;
                      });
                    },
                    onClearFilters: _clearFilters,
                    hasActiveFilters:
                        _searchQuery.isNotEmpty || _selectedGenres.isNotEmpty,
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: _MovieResults(movies: visibleMovies)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeadingSection extends StatelessWidget {
  const _HeadingSection({
    required this.visibleCount,
    required this.selectedGenreCount,
    required this.isWideScreen,
  });

  final int visibleCount;
  final int selectedGenreCount;
  final bool isWideScreen;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w900,
      color: const Color(0xFF173B33),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Find a Movie', style: titleStyle),
              const SizedBox(height: 6),
              Text(
                'Browse by title, genre, year, and rating.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF5E6872),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (isWideScreen) ...[
          const SizedBox(width: 16),
          _ResultBadge(
            label: '$visibleCount movies',
            icon: Icons.movie_filter_outlined,
          ),
          const SizedBox(width: 8),
          _ResultBadge(
            label: '$selectedGenreCount genres',
            icon: Icons.local_offer_outlined,
          ),
        ],
      ],
    );
  }
}

class _ResultBadge extends StatelessWidget {
  const _ResultBadge({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4F0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD2E5DE)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 17, color: const Color(0xFF2F6F5E)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF245549),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterSection extends StatelessWidget {
  const _FilterSection({
    required this.genres,
    required this.sortOptions,
    required this.selectedGenres,
    required this.selectedSort,
    required this.searchController,
    required this.onSearchChanged,
    required this.onGenrePressed,
    required this.onSortChanged,
    required this.onClearFilters,
    required this.hasActiveFilters,
  });

  final List<String> genres;
  final List<String> sortOptions;
  final Set<String> selectedGenres;
  final String selectedSort;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onGenrePressed;
  final ValueChanged<String?> onSortChanged;
  final VoidCallback onClearFilters;
  final bool hasActiveFilters;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE1E5E9)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final controlsAreWide = constraints.maxWidth >= 700;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (controlsAreWide)
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: _SearchField(
                          controller: searchController,
                          onChanged: onSearchChanged,
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 180,
                        child: _SortDropdown(
                          sortOptions: sortOptions,
                          selectedSort: selectedSort,
                          onChanged: onSortChanged,
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _SearchField(
                        controller: searchController,
                        onChanged: onSearchChanged,
                      ),
                      const SizedBox(height: 12),
                      _SortDropdown(
                        sortOptions: sortOptions,
                        selectedSort: selectedSort,
                        onChanged: onSortChanged,
                      ),
                    ],
                  ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final genre in genres)
                      ChoiceChip(
                        label: Text(genre),
                        selected: selectedGenres.contains(genre),
                        onSelected: (_) => onGenrePressed(genre),
                      ),
                  ],
                ),
                if (hasActiveFilters || selectedGenres.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: onClearFilters,
                      icon: const Icon(Icons.close),
                      label: const Text('Clear filters'),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Search movie title...',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFFF5F7F8),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _SortDropdown extends StatelessWidget {
  const _SortDropdown({
    required this.sortOptions,
    required this.selectedSort,
    required this.onChanged,
  });

  final List<String> sortOptions;
  final String selectedSort;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedSort,
      items: [
        for (final option in sortOptions)
          DropdownMenuItem(value: option, child: Text(option)),
      ],
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.sort),
        filled: true,
        fillColor: const Color(0xFFF5F7F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _MovieResults extends StatelessWidget {
  const _MovieResults({required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (movies.isEmpty) {
          return const Center(
            child: Text(
              'No movies match your filters.',
              style: TextStyle(
                color: Color(0xFF5E6872),
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        }

        if (constraints.maxWidth >= 800) {
          return GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.55,
            children: [for (final movie in movies) _MovieCard(movie: movie)],
          );
        }

        return ListView.separated(
          itemCount: movies.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return SizedBox(
              height: 176,
              child: _MovieCard(movie: movies[index]),
            );
          },
        );
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final posterWidth = constraints.maxWidth >= 480 ? 145.0 : 112.0;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: posterWidth,
                child: Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const ColoredBox(
                    color: Color(0xFFEAF4F0),
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Color(0xFF2F6F5E),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          height: 1.15,
                          color: Color(0xFF17231F),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${movie.year}',
                        style: const TextStyle(
                          color: Color(0xFF5E6872),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          for (final genre in movie.genres)
                            _TinyGenrePill(label: genre),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 18,
                            color: Color(0xFFE0A11B),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF17231F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TinyGenrePill extends StatelessWidget {
  const _TinyGenrePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1E8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF9A4C1E),
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class Movie {
  const Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });

  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;
}

const List<Movie> allMovies = [
  Movie(
    title: 'Skyline Chase',
    year: 2024,
    genres: ['Action', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/skyline-chase/500/760',
    rating: 4.7,
  ),
  Movie(
    title: 'Quiet Harbor',
    year: 2021,
    genres: ['Drama'],
    posterUrl: 'https://picsum.photos/seed/quiet-harbor/500/760',
    rating: 4.4,
  ),
  Movie(
    title: 'Moon Arcade',
    year: 2023,
    genres: ['Comedy', 'Sci-Fi'],
    posterUrl: 'https://picsum.photos/seed/moon-arcade/500/760',
    rating: 4.2,
  ),
  Movie(
    title: 'Forest of Echoes',
    year: 2020,
    genres: ['Fantasy', 'Adventure'],
    posterUrl: 'https://picsum.photos/seed/forest-echoes/500/760',
    rating: 4.6,
  ),
  Movie(
    title: 'Paper Planets',
    year: 2022,
    genres: ['Animation', 'Adventure'],
    posterUrl: 'https://picsum.photos/seed/paper-planets/500/760',
    rating: 4.8,
  ),
  Movie(
    title: 'Midnight Signal',
    year: 2019,
    genres: ['Sci-Fi', 'Thriller'],
    posterUrl: 'https://picsum.photos/seed/midnight-signal/500/760',
    rating: 4.1,
  ),
  Movie(
    title: 'The Last Recipe',
    year: 2018,
    genres: ['Drama', 'Comedy'],
    posterUrl: 'https://picsum.photos/seed/last-recipe/500/760',
    rating: 4.0,
  ),
  Movie(
    title: 'Neon River',
    year: 2025,
    genres: ['Action', 'Sci-Fi'],
    posterUrl: 'https://picsum.photos/seed/neon-river/500/760',
    rating: 4.9,
  ),
];
