using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using QuanLiThuVien.Models;
using System.Web.Mvc;

namespace QuanLiThuVien.Controllers
{
    public class HoTroDocGiaController : Controller
    {
     
        //
        // GET: /HoTroDocGia/
        public static QLThuVienEntities4 data;
        public ActionResult main()
        {
            data = new QLThuVienEntities4();
            return View();
        }
        public ActionResult XemThongtinmuon()
        {
            string tt = Session["username"].ToString().Trim();
            var result = (from p in data.phieumuons
                         where p.tbl_DocGia.ID == tt & p.Ngaytra==null //Where data.Docgias.ID=data.phieumuon.IDdocgia and data.Docgias.username=getSession(sender,e)
                         select p);
            return View(result);
        }
        public ActionResult giahan(int id)
        {

            if (id >= 0)
            {
                //QuanlyEntities23 data = new QuanlyEntities2(); 
                data.sp_Giahan(id);//Goi procedure Gia han sach trong SQLserver
                data.SaveChanges();
                data = new QLThuVienEntities4();
                //return RedirectToAction("XemThongtinmuon","Home");
            }
            
            string tt = Session["username"].ToString().Trim();
            var result = (from p in data.phieumuons
                          where p.tbl_DocGia.ID == tt & p.Ngaytra == null //Where data.Docgias.ID=data.phieumuon.IDdocgia and data.Docgias.username=getSession(sender,e)
                          select p);
            return View(result);
        }
    }
}
