shared_examples "Readable" do

  it "node exists" do
    expect(subject).to respond_to :node
  end

  it "when subject saved, it will be saved" do
    expect {
      subject.save
    }.to change { !!subject.node.try(:persisted?) }.from(false).to(true)
  end

  it "when runs validations it builds a node" do
    expect(subject.node).to be_nil
    subject.valid?
    expect(subject.node).to be
  end

  [:node, :read, :unread, :read?, :books, :similar_raters].each do |method|
    it "#{method} is exists" do
      expect(subject.methods).to include method
    end
  end

end