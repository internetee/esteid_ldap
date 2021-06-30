# frozen_string_literal: true

require 'test_helper'
require 'pry'

class EsteidLdapTest < ActiveSupport::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::EsteidLdap::VERSION
  end

  def test_search_existing_ident_code
    assert MockEsteidLdap.search_by_ident('10101010005', false)
  end

  def test_search_non_existing_ident_code
    assert_not MockEsteidLdap.search_by_ident('2222222', false)
  end

  def test_information_about_ident
    result = MockEsteidLdap.search_by_ident('10101010005', true)
    assert result[:dn].include? 'cn=SUPREME\\2CMARIA\\2C10101010005,ou=Authentication,o=Residence card of long-term resident,dc=ESTEID,c=EE'
    assert_equal result[:objectclass], %w[top person organizationalPerson inetOrgPerson]
    assert_equal result[:cn], ['SUPREME,MARIA,10101010005']
    assert_equal result[:serialNumber], ['PNOEE-10101010005']
    assert_equal result[:"usercertificate;binary"], user_certificate
  end

  def test_information_about_ident
    result = MockEsteidLdap.search_by_ident('2222222', true)

    assert_not result
  end

  private

  def user_certificate
    ["0\x82\u0003\xDF0\x82\u0003@\xA0\u0003\u0002\u0001\u0002\u0002\u0010!\xB4\xDF\u0014\xC6E/w`A\xECk\x96\xCE\xF0\xF40\n\u0006\b*\x86H\xCE=\u0004\u0003\u00040X1\v0\t\u0006\u0003U\u0004\u0006\u0013\u0002EE1\e0\u0019\u0006\u0003U\u0004\n\f\u0012SK ID Solutions AS1\u00170\u0015\u0006\u0003U\u0004a\f\u000ENTREE-107470131\u00130\u0011\u0006\u0003U\u0004\u0003\f\nESTEID20180\u001E\u0017\r210305083139Z\u0017\r260304215959Z0o1\v0\t\u0006\u0003U\u0004\u0006\u0013\u0002EE1\"0 \u0006\u0003U\u0004\u0003\f\u0019SUPREME,MARIA,101010100051\u00110\u000F\u0006\u0003U\u0004\u0004\f\bHASJANOV1\r0\v\u0006\u0003U\u0004*\f\u0004OLEG1\u001A0\u0018\u0006\u0003U\u0004\u0005\u0013\u0011PNOEE-101010100050v0\u0010\u0006\a*\x86H\xCE=\u0002\u0001\u0006\u0005+\x81\u0004\u0000\"\u0003b\u0000\u0004\xC88\u0005\x93,\u0013\u0011\a4\xABa\u0012F\x91K(\u0014\x9B\xB8|e\u001DBM\xD6j\x88\u0011\x9D7\u00190\x94\x81c8d&\xC7\xE9m\"\r\u0002\xA9\x908/\xB1\xA7T \xFB\xE7\xCD\xE3'$U\xB5\x85\xFF\xAAND\xC3\xC7^x\x80\u0017\u0001\x89\xAE\xF2\u00154\xF3E\x9B\u0018\xBCa\x80\xA5d\xC3\u0003@\xB9\xE1\xE0\e\xB5\xD7ޣ\x82\u0001\xB60\x82\u0001\xB20\t\u0006\u0003U\u001D\u0013\u0004\u00020\u00000\u000E\u0006\u0003U\u001D\u000F\u0001\u0001\xFF\u0004\u0004\u0003\u0002\u0003\x880G\u0006\u0003U\u001D \u0004@0>02\u0006\v+\u0006\u0001\u0004\u0001\x83\x91!\u0001\u0001\u00050#0!\u0006\b+\u0006\u0001\u0005\u0005\a\u0002\u0001\u0016\u0015https://www.sk.ee/CPS0\b\u0006\u0006\u0004\u0000\x8Fz\u0001\u00020\u001F\u0006\u0003U\u001D\u0011\u0004\u00180\u0016\x81\u001438903110313@eesti.ee0\u001D\u0006\u0003U\u001D\u000E\u0004\u0016\u0004\u00146T1\u0012\xE4\x98d.\xFE\xA5\u0013^Jc\xD5P\e\x9Fx\u007F0a\u0006\b+\u0006\u0001\u0005\u0005\a\u0001\u0003\u0004U0S0Q\u0006\u0006\u0004\u0000\x8EF\u0001\u00050G0E\u0016?https://sk.ee/en/repository/conditions-for-use-of-certificates/\u0013\u0002EN0 \u0006\u0003U\u001D%\u0001\u0001\xFF\u0004\u00160\u0014\u0006\b+\u0006\u0001\u0005\u0005\a\u0003\u0002\u0006\b+\u0006\u0001\u0005\u0005\a\u0003\u00040\u001F\u0006\u0003U\u001D#\u0004\u00180\u0016\x80\u0014٬p\xDB_~\xBE\x94\xF8\xA0\xE4\xBEG\xA2\xD04\xAD\x9A*\u00120f\u0006\b+\u0006\u0001\u0005\u0005\a\u0001\u0001\u0004Z0X0'\u0006\b+\u0006\u0001\u0005\u0005\a0\u0001\x86\ehttp://aia.sk.ee/esteid20180-\u0006\b+\u0006\u0001\u0005\u0005\a0\u0002\x86!http://c.sk.ee/esteid2018.der.crt0\n\u0006\b*\x86H\xCE=\u0004\u0003\u0004\u0003\x81\x8C\u00000\x81\x88\u0002B\u0001\xE3S,Xy\xEA@*-\f\x8B#c\x85\xE8P\xB0j\xEA\u001D.)\x8E\u0001\xE7\xC0\u0003\xC0\xE1\tb\xBE\xE0c\x8F\xD5&X\xC54\xDC\xF4\xC4n\u0000\x85\r1ۄ\xF7\u000F\xB5\xBF\xF0\b>\u0018\u0019\b\n`\xA4.\xDE\u0002B\u0001.M\xAD\xBD\u0004\u0015\u001Fly\xE5\x8A\xD8\u001F\vE3\xD9\u001Da\xF9K=\xF75QӮt\xFA\x8D\xE8j\u0010\tg\xEFl\xD2s\"\xF59Z3(h\u001C\x80\xFB\xCC\u007F[ |*\xA7\xEBM\u0005\u000F\xBA(7yd"]
  end

  class MockEsteidLdap
    class << self
      def search_by_ident(code, data)
        return result_with_data(code) if data

        result_without_data(code)
      end

      private

      def result_without_data(code)
        return true if code == '10101010005'

        false
      end

      def result_with_data(code)
        data = mock_response
        return parse_result_to_json(data) if code == '10101010005'

        false
      end

      def parse_result_to_json(result)
        json = {}

        {
          'dn': result[0][:dn],
          'objectclass': result[0][:objectclass],
          'cn': result[0][:cn],
          'serialNumber': result[0][:serialnumber],
          "usercertificate;binary": result[0][:"usercertificate;binary"]
        }
      end

      def mock_response
        [{
          dn: ['cn=SUPREME\\2CMARIA\\2C10101010005,ou=Authentication,o=Residence card of long-term resident,dc=ESTEID,c=EE'], objectclass: %w[
            top person organizationalPerson inetOrgPerson
          ], cn: ['SUPREME,MARIA,10101010005'], serialnumber: ['PNOEE-10101010005'], "usercertificate;binary": ["0\x82\x03\xDF0\x82\x03@\xA0\x03\x02\x01\x02\x02\x10!\xB4\xDF\x14\xC6E/w`A\xECk\x96\xCE\xF0\xF40\n\x06\b*\x86H\xCE=\x04\x03\x040X1\v0\t\x06\x03U\x04\x06\x13\x02EE1\e0\x19\x06\x03U\x04\n\f\x12SK ID Solutions AS1\x170\x15\x06\x03U\x04a\f\x0ENTREE-107470131\x130\x11\x06\x03U\x04\x03\f\nESTEID20180\x1E\x17\r210305083139Z\x17\r260304215959Z0o1\v0\t\x06\x03U\x04\x06\x13\x02EE1\"0 \x06\x03U\x04\x03\f\x19SUPREME,MARIA,101010100051\x110\x0F\x06\x03U\x04\x04\f\bHASJANOV1\r0\v\x06\x03U\x04*\f\x04OLEG1\x1A0\x18\x06\x03U\x04\x05\x13\x11PNOEE-101010100050v0\x10\x06\a*\x86H\xCE=\x02\x01\x06\x05+\x81\x04\x00\"\x03b\x00\x04\xC88\x05\x93,\x13\x11\a4\xABa\x12F\x91K(\x14\x9B\xB8|e\x1DBM\xD6j\x88\x11\x9D7\x190\x94\x81c8d&\xC7\xE9m\"\r\x02\xA9\x908/\xB1\xA7T \xFB\xE7\xCD\xE3'$U\xB5\x85\xFF\xAAND\xC3\xC7^x\x80\x17\x01\x89\xAE\xF2\x154\xF3E\x9B\x18\xBCa\x80\xA5d\xC3\x03@\xB9\xE1\xE0\e\xB5\xD7\xDE\xA3\x82\x01\xB60\x82\x01\xB20\t\x06\x03U\x1D\x13\x04\x020\x000\x0E\x06\x03U\x1D\x0F\x01\x01\xFF\x04\x04\x03\x02\x03\x880G\x06\x03U\x1D \x04@0>02\x06\v+\x06\x01\x04\x01\x83\x91!\x01\x01\x050#0!\x06\b+\x06\x01\x05\x05\a\x02\x01\x16\x15https://www.sk.ee/CPS0\b\x06\x06\x04\x00\x8Fz\x01\x020\x1F\x06\x03U\x1D\x11\x04\x180\x16\x81\x1438903110313@eesti.ee0\x1D\x06\x03U\x1D\x0E\x04\x16\x04\x146T1\x12\xE4\x98d.\xFE\xA5\x13^Jc\xD5P\e\x9Fx\x7F0a\x06\b+\x06\x01\x05\x05\a\x01\x03\x04U0S0Q\x06\x06\x04\x00\x8EF\x01\x050G0E\x16?https://sk.ee/en/repository/conditions-for-use-of-certificates/\x13\x02EN0 \x06\x03U\x1D%\x01\x01\xFF\x04\x160\x14\x06\b+\x06\x01\x05\x05\a\x03\x02\x06\b+\x06\x01\x05\x05\a\x03\x040\x1F\x06\x03U\x1D#\x04\x180\x16\x80\x14\xD9\xACp\xDB_~\xBE\x94\xF8\xA0\xE4\xBEG\xA2\xD04\xAD\x9A*\x120f\x06\b+\x06\x01\x05\x05\a\x01\x01\x04Z0X0'\x06\b+\x06\x01\x05\x05\a0\x01\x86\ehttp://aia.sk.ee/esteid20180-\x06\b+\x06\x01\x05\x05\a0\x02\x86!http://c.sk.ee/esteid2018.der.crt0\n\x06\b*\x86H\xCE=\x04\x03\x04\x03\x81\x8C\x000\x81\x88\x02B\x01\xE3S,Xy\xEA@*-\f\x8B#c\x85\xE8P\xB0j\xEA\x1D.)\x8E\x01\xE7\xC0\x03\xC0\xE1\tb\xBE\xE0c\x8F\xD5&X\xC54\xDC\xF4\xC4n\x00\x85\r1\xDB\x84\xF7\x0F\xB5\xBF\xF0\b>\x18\x19\b\n`\xA4.\xDE\x02B\x01.M\xAD\xBD\x04\x15\x1Fly\xE5\x8A\xD8\x1F\vE3\xD9\x1Da\xF9K=\xF75Q\xD3\xAEt\xFA\x8D\xE8j\x10\tg\xEFl\xD2s\"\xF59Z3(h\x1C\x80\xFB\xCC\x7F[ |*\xA7\xEBM\x05\x0F\xBA(7yd"]
        }]
      end
    end
  end
end
