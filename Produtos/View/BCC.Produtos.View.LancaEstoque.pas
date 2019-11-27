unit BCC.Produtos.View.LancaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BCC.View.FormBase, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Samples.Spin, BCC.DAO.Produto;

type
  TFrmLancaEstoque = class(TFrmBase)
    LblEstoque: TLabel;
    SedEstoque: TSpinEdit;
    BtnAdicionar: TButton;
    BtnRemover: TButton;
    procedure BtnAdicionarClick(Sender: TObject);
    procedure BtnRemoverClick(Sender: TObject);
  private
    { Private declarations }
    CodProduto : Integer;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; ACodProduto : Integer); overload;
  end;

var
  FrmLancaEstoque: TFrmLancaEstoque;

implementation

{$R *.dfm}

{ TFrmLancaEstoque }

procedure TFrmLancaEstoque.BtnAdicionarClick(Sender: TObject);
begin
  inherited;
  TDmProduto.Create(Self).AjustarEstoque(Self.CodProduto, Self.SedEstoque.Value);
end;

procedure TFrmLancaEstoque.BtnRemoverClick(Sender: TObject);
begin
  inherited;
  TDmProduto.Create(Self).AjustarEstoque(Self.CodProduto, (Self.SedEstoque.Value) * -1);
  Self.Close();
end;

constructor TFrmLancaEstoque.Create(AOwner: TComponent; ACodProduto: Integer);
begin
  inherited Create(AOwner);
  Self.CodProduto := ACodProduto;
  Self.Close();
end;

end.
