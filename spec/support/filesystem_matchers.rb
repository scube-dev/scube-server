RSpec::Matchers.define :eq_file_content do |expected_file_path|
  match do |actual|
    expect(actual).to eq File.read(expected_file_path, mode: 'rb')
  end

  failure_message do |actual|
    generate_message actual
  end

  failure_message_when_negated do |actual|
    generate_message actual, 'not to eq'
  end

  def generate_message actual, verb = 'to eq'
    "expected `#{actual[0..15].inspect.tr ?", ''}...'" \
      " #{verb} `#{expected}' content"
  end
end
