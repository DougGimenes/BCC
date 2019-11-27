unit BCC.Conexao.DAO.Dados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB, BCC.Model.Usuario;

type
  TDmDados = class(TDataModule)
    AcoConexao: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    FUsuario: TUsuario;
    FCodCaixa: Integer;
    { Private declarations }
  public
    { Public declarations }
    property Usuario: TUsuario read FUsuario write FUsuario;
    property CodCaixa: Integer read FCodCaixa write FCodCaixa;
  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmDados.DataModuleCreate(Sender: TObject);
begin
  Self.AcoConexao.Close();
  Self.AcoConexao.ConnectionString := 'Provider=SQLOLEDB.1;Password=segredo902;Persist Security Info=True;User ID=Douglas;Initial Catalog=BCC;Data Source=DOUGLAS-PC\BCCSQL';
  Self.AcoConexao.Open();
end;

end.
