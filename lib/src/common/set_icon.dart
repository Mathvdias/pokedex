String setTypeIcon(String type) {
  switch (type) {
    case 'fire':
      return 'G';
    case 'grass':
      return 'J';
    case 'water':
      return 'R';
    case 'rock':
      return 'P';
    case 'bug':
      return 'A';
    case 'normal':
      return 'M';
    case 'poison':
      return 'N';
    case 'electric':
      return 'D';
    case 'ground':
      return 'K';
    case 'ice':
      return 'L';
    case 'dark':
      return 'B';
    case 'fairy':
      return 'E';
    case 'psychic':
      return 'O';
    case 'fighting':
      return 'F';
    case 'ghost':
      return 'I';
    case 'flying':
      return 'H';
    case 'dragon':
      return 'C';
    case 'steel':
      return 'Q';
    default:
      return 'A';
  }
}
