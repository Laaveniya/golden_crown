class Southeros
  attr_accessor :kingdoms_acquired, :alies

  KINGDOMS = {
    land: { emblem:  'panda' },
    water: { emblem: 'octopus' },
    ice: { emblem: 'mammoth' },
    air: { emblem: 'owl' },
    fire: { emblem: 'dragon' }
  }.freeze

  module Rulers
    NONE = 'None'.freeze
    KING_SHAN = 'King Shan'.freeze
  end

  def initialize
    @kingdoms_acquired = 0
    @alies = []
  end

  def universal_question
    puts 'Who is the ruler of Southeros?'
    calculated_ruler
    puts 'Alies of Ruler'
    puts list_alies
  end

  def conquer_kingdoms
    puts 'Input Messages to kingdoms from King Shan:'
    decrypt_secret_messages(conquer_attempts)
  end

  def decrypt_secret_messages(conquer_attempts)
    conquer_attempts.each do |attempt|
      kingdom, secret_message = attempt.split(',')
      kingdom_name = sanitize_kingdom_name(kingdom)
      next unless valid_kingdom?(kingdom_name)

      manipulate_conquer_status(kingdom_name, secret_message)
    end
  end

  def sanitize_kingdom_name(kingdom)
    kingdom.downcase.to_sym
  end

  def valid_kingdom?(kingdom_name)
    KINGDOMS.keys.include?(kingdom_name)
  end

  def manipulate_conquer_status(kingdom_name, secret_message)
    results = compute_win(kingdom_emblem(kingdom_name), secret_message.downcase)
    publish_results(results, kingdom_name)
  end

  def kingdom_emblem(kingdom_name)
    KINGDOMS[kingdom_name][:emblem]
  end

  def compute_win(kingdom_emblem, secret_message)
    kingdom_emblem_letters = kingdom_emblem.split('')
    secret_emblems_letters =
      secret_message_emblems_letters(secret_message, kingdom_emblem_letters)
    secret_hash = compute_hash(secret_emblems_letters)
    kingdom_emblem_hash = compute_hash(kingdom_emblem_letters)
    compare_hashes(kingdom_emblem_hash, secret_hash)
  end

  def publish_results(results, kingdom_name)
    return unless results

    @kingdoms_acquired += 1
    alies << kingdom_name.to_s.capitalize
  end

  def compare_hashes(hash1, hash2)
    result = true
    hash1.each do |key, value|
      result = result && (hash2[key] >= value)
    end
    result
  end

  def secret_message_emblems_letters(secret_message, kingdom_emblem_letters)
    secret_message.split('').map do |key|
      next unless kingdom_emblem_letters.include?(key)
      key
    end.compact
  end

  def compute_hash(letters)
    letters.each_with_object(Hash.new(0)) { |key, hash| hash[key] += 1 }
  end

  def calculated_ruler
    if kingdoms_acquired < 3
      p Rulers::NONE
    else
      p Rulers::KING_SHAN
    end
  end

  def list_alies
    return 'None' if alies.empty?

    alies.join(',')
  end

  def conquer_attempts
    all_text = ''
    until (text = gets) == "\n"
      all_text << text
    end
    all_text.chomp.split("\n")
  end
end



