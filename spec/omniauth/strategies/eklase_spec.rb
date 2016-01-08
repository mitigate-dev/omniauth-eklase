require 'spec_helper'

describe OmniAuth::Strategies::Eklase do
  let(:app) do
    Rack::Builder.new do
      use(OmniAuth::Test::PhonySession)
      use(OmniAuth::Strategies::Eklase, 'CLIENT_ID', 'CLIENT_SECRET')
      run lambda { |env| [404, {'Content-Type' => 'text/plain'}, [env.key?('omniauth.auth').to_s]] }
    end.to_app
  end

  let(:client_id)     { 'CLIENT_ID' }
  let(:client_secret) { 'CLIENT_SECRET' }
  let(:callback_url)  { 'http%3A%2F%2Fexample.org%2Fauth%2Feklase%2Fcallback' }
  let(:code)          { 'fcc34a30-8f44-402d-b25d-138b1d7f6db6' }
  let(:access_token)  { '74e81134-2a6c-4b91-8e76-f9a116223ed9' }
  let(:state)         { app.instance_variable_get(:@session)["omniauth.state"] }

  describe '/auth/eklase' do
    it 'redirects to login.e-klase.lv' do
      get '/auth/eklase'
      expect(last_response).to be_redirect
      expect(last_response.headers['Location']).to eq(
        "https://login.e-klase.lv/Auth/OAuth/" \
        "?client_id=#{client_id}" \
        "&redirect_uri=#{callback_url}" \
        "&response_type=code" \
        "&state=#{state}"
      )
    end
  end

  describe '/auth/eklase/callback' do
    context 'with successful authentication' do
      before do
        stub_get_access_token_request
        stub_get_me_request

        get "/auth/eklase"
        get "/auth/eklase/callback?code=#{code}&state=#{state}"
      end

      let(:auth) { last_request.env['omniauth.auth'] }

      it 'returns provider' do
        expect(auth.provider).to eq('eklase')
      end

      it 'returns uid' do
        expect(auth.uid).to eq('skolens123456789')
      end

      it 'returns info' do
        expect(auth.info).to eq(
          "id"                   => "99895d09-a454-4f46-9a26-35b4d038c6fe",
          "first_name"           => "Ivo",
          "last_name"            => "Paraugs",
          "person_type"          => "Student",
          "user_name"            => "skolens123456789",
          "school_id"            => "IDACC-ORG-20111012-BBBF04AC",
          "school"               => "Testa skola",
          "class_number"         => "8",
          "class_number_postfix" => "b",
          "class_alias"          => "8.b (PĢ)"
        )
      end

      it 'returns credentials' do
        expect(auth.credentials['token']).to eq(access_token)
      end

      it 'returns extra' do
        expect(auth.extra.raw_info).to eq(
          "Person" => {
            "ID"                 => "99895d09-a454-4f46-9a26-35b4d038c6fe",
            "FirstName"          => "Ivo",
            "LastName"           => "Paraugs",
            "PersonType"         => "Student",
            "UserName"           => "skolens123456789",
            "SchoolId"           => "IDACC-ORG-20111012-BBBF04AC",
            "School"             => "Testa skola",
            "ClassNumber"        => "8",
            "ClassNumberPostfix" => "b",
            "ClassAlias"         => "8.b (PĢ)"
          }
        )
      end
    end
  end

  private

  def stub_get_access_token_request
    stub_request(:get,
      "https://login.e-klase.lv/Auth/OAuth/GetAccessToken/" \
      "?client_id=#{client_id}" \
      "&client_secret=#{client_secret}" \
      "&code=#{code}" \
      "&grant_type=authorization_code" \
      "&redirect_uri=#{callback_url}"
    ).to_return(
      headers: {
        'content-type' => "text/plain; charset=utf-8",
      },
      body: "access_token=#{access_token}&expires=3600"
    )
  end

  def stub_get_me_request
    stub_request(:get,
      "https://login.e-klase.lv/Auth/OAuth/API/Me" \
      "?access_token=#{access_token}"
    ).to_return(
      headers: {
        'content-type' => "text/html"
      },
      body: "\xEF\xBB\xBF" \
        "<?xml version=\"1.0\" encoding=\"utf-8\"?>" \
        "<Person>" \
          "<ID>99895d09-a454-4f46-9a26-35b4d038c6fe</ID>" \
          "<FirstName>Ivo</FirstName>" \
          "<LastName>Paraugs</LastName>" \
          "<PersonType>Student</PersonType>" \
          "<UserName>skolens123456789</UserName>" \
          "<SchoolId>IDACC-ORG-20111012-BBBF04AC</SchoolId>" \
          "<School>Testa skola</School>" \
          "<ClassNumber>8</ClassNumber>" \
          "<ClassNumberPostfix>b</ClassNumberPostfix>" \
          "<ClassAlias>8.b (P\xC4\xA2)</ClassAlias>" \
        "</Person>"
    )
  end
end
