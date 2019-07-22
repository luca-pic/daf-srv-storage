/*
 * Copyright 2017 TEAM PER LA TRASFORMAZIONE DIGITALE
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package controllers

import java.io.FileNotFoundException

import daf.catalogmanager._

import scala.util.{ Failure, Success }

trait TestCatalogClient { this: DatasetController =>

  override protected val catalogClient = new TestCatalogManagerClient

}

sealed class TestCatalogManagerClient extends CatalogManagerClient("") {

  private def makeCatalog(id: String) = MetaCatalog(
    dataschema  = DatasetCatalog(
      encoding = None,
      avro = null,
      flatSchema = List.empty,
      kyloSchema = None
    ),
    operational = Operational(
      theme              = "",
      subtheme           = "",
      logical_uri        = Some(id),
      physical_uri       = Some { s"test-dir/$id" },
      is_std             = true,
      group_own          = "test",
      std_schema         = None,
      read_type          = "",
      dataset_type       = "",
      is_vocabulary      = None,
      ext_opendata       = None,
      acl                = None,
      file_type          = None,
      partitions         = None,
      dataset_proc       = None,
      type_info          = None,
      input_src          = null,
      storage_info       = None
    ),
    dcatapit = null
  )

  override def getById(authorization: String, catalogId: String) = catalogId match {
    case "path/to/failure" => Failure { new FileNotFoundException("Encountered failure condition") }
    case other             => Success { makeCatalog(other) }
  }

}
